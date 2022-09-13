import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/utils/utils.dart';
import 'package:whatsapp_clone_flutter/models/user_models.dart';
import 'package:whatsapp_clone_flutter/screens/mobile_chat_screen.dart';

final selectContactsRepositoryProvider = Provider(
  (ref) => SelectContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollections = await firestore.collection("users").get();
      bool isFound = false;
      for (var document in userCollections.docs) {
        var userData = UserModel.fromMap(document.data());
        String phonenum = selectedContact.phones[0].number.replaceAll(' ', '');
        if (phonenum == userData.phoneNumber) {
          isFound = true;
          print(userData.phoneNumber);
          Navigator.pushNamed(context, MobileChatScreen.routeName,
              arguments: {'name': userData.name, 'uid': userData.uid});
        }
      }
      if (!isFound) {
        showSnackBar(context: context, content: "THis contact is not founds");
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
