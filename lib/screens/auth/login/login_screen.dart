import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti_whatsapp_clone/controllers/auth_controller.dart';
import 'package:serti_whatsapp_clone/themes/theme.dart';
import 'package:serti_whatsapp_clone/utils/app_functional_utils.dart';
import 'package:serti_whatsapp_clone/utils/app_screen_utils.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? _country;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void sendPhoneNumber() {
    //! TRIM TO REMOVE WHITE SPACES
    String phoneNumber = phoneController.text.trim();

    _country != null && phoneNumber.isNotEmpty
        ? {
            //! REF.READ IS SAME AS PROVIDER.OF(CONTEXT, LISTEN: FALSE)
            log("Authenticating User"),
            ref.read(authControllerProvider).signInWithPhone(
                theBuildContext: context,
                phoneNumber: "+${_country!.phoneCode}$phoneNumber")
          }
        : {
            AppFunctionalUtils.showSnackBar(
                theBuildContext: context,
                theContent:
                    "One of your Country code or Phone number field is empty. \nKindly fill out all the screens.")
          };
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColours.backgroundColor,
          title: const Text("Enter your phone number")),
      body: Padding(
          padding: AppScreenUtils.appMainPadding,
          child: Column(children: [
            //! NOTICE
            Text("WhatsApp will need to verify your phone number.",
                style: Theme.of(context).textTheme.bodyText1),

            //! SPACER
            const SizedBox(height: 10.0),

            //! PICK COUNTRY
            TextButton(
                onPressed: () => showCountryPicker(
                    context: context,
                    onSelect: (Country country) =>
                        setState(() => _country = country),
                    countryListTheme: CountryListThemeData(
                        bottomSheetHeight:
                            MediaQuery.of(context).size.height * 0.7,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 16.0),
                        backgroundColor: AppColours.backgroundColor)),
                child: Text("Pick Country",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppColours.elevatedButtonColour))),

            //! SPACER
            const SizedBox(height: 10.0),

            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //! COUNTRY CODE
              if (_country != null)
                Text("+${_country!.phoneCode}",
                    style: Theme.of(context).textTheme.bodyText1),

              //! SPACER
              const SizedBox(width: 20),

              //! PHONE NUMBER
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                      controller: phoneController,
                      decoration:
                          const InputDecoration(hintText: "phone number")))
            ]),

            //! SPACER
            const Spacer(),

            //! BUTTON
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => sendPhoneNumber(),
                    child: const Text("Next"))),

            //! SPACER
            const SizedBox(height: 20.0)
          ])));
}
