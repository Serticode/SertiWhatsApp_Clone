import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AppFunctionalUtils {
  //! APP SNACK BAR
  static showSnackBar(
          {required BuildContext theBuildContext,
          required String theContent}) =>
      ScaffoldMessenger.of(theBuildContext)
          .showSnackBar(SnackBar(content: Text(theContent)));

  //! PICK USER IMAGE
  static Future<File?> pickUserImageFromGallery(
      {required BuildContext theBuildContext}) async {
    //! SELECTED IMAGE
    File? selectedImage;

    //! IMAGE PICKER BLOCK
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
      }
    } catch (e) {
      showSnackBar(theBuildContext: theBuildContext, theContent: e.toString());
    }

    return selectedImage;
  }
}
