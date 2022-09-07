import 'package:flutter/material.dart';
import 'package:serti_whatsapp_clone/router/router.dart';
import 'package:serti_whatsapp_clone/router/routes.dart';
import 'package:serti_whatsapp_clone/themes/theme.dart';
import 'package:serti_whatsapp_clone/utils/app_screen_utils.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
          child: Padding(
              padding: AppScreenUtils.appMainPadding,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //! SPACER
                    const Spacer(),

                    //! WELCOME HEADER
                    Text("Welcome to Whatsapp by Serticode",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 28.0)),

                    //! SPACER
                    const Spacer(),

                    //! IMAGE
                    Image.asset("assets/bg.png",
                        width: 340,
                        height: 340,
                        color: AppColours.landingScreenImageColour),

                    //! SPACER
                    const Spacer(),

                    //! NOTICE
                    Text(
                        "Read our Privacy Policy. \nTap 'Agree and continue' to accept the Terms of Service.",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        style: Theme.of(context).textTheme.bodyText1),

                    //! SPACER
                    const Spacer(),

                    //! BUTTON
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () => AppNavigator.navigateToPage(
                                thePageRouteName: AppRoutes.signInRoute,
                                context: context),
                            child: const Text("Agree & Continue"))),

                    //! SPACER
                    const Spacer()
                  ]))));
}
