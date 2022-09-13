import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/utils/colors.dart';
import 'package:whatsapp_clone_flutter/common/widgets/loader.dart';
import 'package:whatsapp_clone_flutter/features/auth/controllers/auth_controller.dart';
import 'package:whatsapp_clone_flutter/models/user_models.dart';
import 'package:whatsapp_clone_flutter/screens/chat/widgets/bottomfieldchat.dart';
import 'package:whatsapp_clone_flutter/screens/chat/widgets/chatlist.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  // final bool isGroupChat;
  // final String profilePic;
  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    //   required this.isGroupChat,
    //   required this.profilePic,

    // void makeCall(WidgetRef ref, BuildContext context) {
    //   ref.read(callControllerProvider).makeCall(
    //         context,
    //         name,
    //         uid,
    //         profilePic,
    //         isGroupChat,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
            stream: ref.read(AuthControllerProvider).userDatabyId(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return Column(
                children: [
                  Text(name),
                  Text(
                    snapshot.data!.isOnline ? 'online' : 'offline',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              );
            }),
        actions: [
          IconButton(
            onPressed: () => "",
            // makeCall(ref, context),
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(
              recieverUserId: uid,
              // isGroupChat: isGroupChat,
            ),
          ),
          BottomChatField(
            recieverUserId: uid,
            // isGroupChat: isGroupChat,
          ),
        ],
      ),
    );
    // CallPickupScreen(
    //   scaffold: Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: appBarColor,
    //       title: isGroupChat
    //           ? Text(name)
    //           : StreamBuilder<UserModel>(
    //               stream: ref.read(authControllerProvider).userDataById(uid),
    //               builder: (context, ,) {

    //               }),

    // );
  }
}
