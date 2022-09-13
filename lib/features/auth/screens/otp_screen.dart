import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_flutter/common/utils/colors.dart';
import 'package:whatsapp_clone_flutter/features/auth/controllers/auth_controller.dart';
// Widget Ref Communicatates Widgets From Providers
class OTPScreen extends ConsumerWidget{
    static const String routeName = '/otp-screen';
    String verificationId;

   OTPScreen({Key? key,required this.verificationId}) : super(key: key);
 
 void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(AuthControllerProvider).verifyOTP(
          context,
          verificationId,
          userOTP,
        );
  }


  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying your number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('We have sent an SMS with a code.'),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(

                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                    verifyOTP(ref, context, val.trim());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}