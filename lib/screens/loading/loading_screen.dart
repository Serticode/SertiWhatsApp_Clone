import 'package:flutter/material.dart';
import 'package:serti_whatsapp_clone/themes/theme.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
          body: SafeArea(
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
            //! LOADER
            const CircularProgressIndicator(
                backgroundColor: AppColours.messageColor,
                strokeWidth: 6.0,
                color: AppColours.elevatedButtonColour),

            //! SPACER
            const SizedBox(height: 20.0),

            //! TEXT
            Text("Whatsapp by Serticode",
                overflow: TextOverflow.visible,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 21.0))
          ]))));
}
