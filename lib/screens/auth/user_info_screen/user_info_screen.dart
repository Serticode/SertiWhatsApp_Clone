import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti_whatsapp_clone/controllers/auth_controller.dart';
import 'package:serti_whatsapp_clone/themes/theme.dart';
import 'package:serti_whatsapp_clone/utils/app_functional_utils.dart';
import 'package:serti_whatsapp_clone/utils/app_screen_utils.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  //! TEXT EDITING CONTROLLER
  final TextEditingController _nameController = TextEditingController();

  //! USER PROFILE IMAGE
  File? _userProfileImage;

  //! STORE USER DATA
  Future<void> storeUserData() async {
    String name = _nameController.text.trim();

    if (name.isNotEmpty) {
      log("Storing user details");
      ref
          .read(authControllerProvider)
          .saveUserDataToFirestore(
              profilePicture: _userProfileImage,
              userName: name,
              theBuildContext: context)
          .whenComplete(() => {
                log("User data stored!"),
                AppFunctionalUtils.showSnackBar(
                    theBuildContext: context,
                    theContent: "Details updated successfully!")
              });
    } else {
      AppFunctionalUtils.showSnackBar(
          theBuildContext: context, theContent: "Kindly add your name");
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColours.backgroundColor,
          title: const Text("User info Screen")),
      body: Padding(
          padding: AppScreenUtils.appMainPadding,
          child: Center(
              child: Form(
                  child: Column(children: [
            //! SPACER
            const SizedBox(height: 20.0),

            //! IMAGE AND ADD IMAGE ICON
            InkWell(
                onTap: () async => await AppFunctionalUtils
                        .pickUserImageFromGallery(theBuildContext: context)
                    .then((value) => setState(() => _userProfileImage = value)),
                child: Stack(children: [
                  //! IMAGE
                  _userProfileImage != null
                      ? CircleAvatar(
                          radius: 70.0,
                          backgroundColor: const Color.fromRGBO(0, 167, 131, 1),
                          child: CircleAvatar(
                              radius: 65.0,
                              backgroundImage: FileImage(_userProfileImage!)))
                      : const CircleAvatar(
                          radius: 70.0,
                          backgroundColor: Color.fromRGBO(0, 167, 131, 1),
                          child: CircleAvatar(
                              radius: 65.0,
                              backgroundImage: AssetImage("assets/bg.png"))),

                  //! ICON
                  const PositionedDirectional(
                      bottom: 12,
                      end: 12,
                      child: Icon(Icons.add_a_photo_outlined))
                ])),

            //! SPACER
            const SizedBox(height: 20.0),

            //! TEXT FIELD.
            Row(children: [
              Expanded(
                  child: TextFormField(
                      controller: _nameController,
                      decoration:
                          const InputDecoration(hintText: "Enter your name"))),

              //! SPACER
              const SizedBox(width: 20.0),

              //! ICON
              const Icon(Icons.done, size: 21.0)
            ]),

            //! SPACER
            const SizedBox(height: 20.0),

            //! SAVE DETAILS BUTTON
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => storeUserData(),
                    child: const Text("Save Details")))
          ])))));
}
