import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti_whatsapp_clone/controllers/auth_controller.dart';
import 'package:serti_whatsapp_clone/themes/theme.dart';
import 'package:serti_whatsapp_clone/utils/app_screen_utils.dart';

class OTPScreen extends ConsumerWidget {
  final String verificationID;
  const OTPScreen({super.key, required this.verificationID});

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref.read(authControllerProvider).verifyOTP(
          theBuildContext: context,
          verificationID: verificationID,
          userOTP: userOTP,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColours.backgroundColor,
          title: const Text("Verify your number")),
      body: Padding(
          padding: AppScreenUtils.appMainPadding,
          child: Column(children: [
            //! SPACER
            const SizedBox(height: 20.0),

            //! NOTICE
            Text(
                "An SMS with your verification code has been sent to the number you entered.",
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),

            //! SPACER
            const SizedBox(height: 20.0),

            SizedBox(
                width: double.infinity,
                child: TextField(
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                        hintText: "- - - - - -",
                        hintStyle: TextStyle(fontSize: 30)),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 6) {
                        verifyOTP(ref, context, value.trim());
                      }
                    }))
          ])));
}
