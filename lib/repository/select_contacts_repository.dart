import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti_whatsapp_clone/models/user_model.dart';
import 'package:serti_whatsapp_clone/router/router.dart';
import 'package:serti_whatsapp_clone/router/routes.dart';
import 'package:serti_whatsapp_clone/utils/app_functional_utils.dart';

final selectContactsRepositoryProvider = Provider((ref) =>
    SelectContactsRepository(firebaseFirestore: FirebaseFirestore.instance));

class SelectContactsRepository {
  final FirebaseFirestore firebaseFirestore;

  SelectContactsRepository({required this.firebaseFirestore});

  //! METHOD
  //! GET THE USER CONTACTS
  Future<List<Contact>> getUserContacts() async {
    //! LIST OF CONTACTS
    List<Contact> userContacts = [];
    try {
      //! REQUEST PERMISSION TO GET CONTACTS
      if (await FlutterContacts.requestPermission()) {
        //! ASSIGN THE CONTACTS
        userContacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      log(e.toString());
    }

    return userContacts;
  }

  //! SELECTED CONTACT
  Future<void> selectContact(
      {required Contact selectedContact,
      required BuildContext theContext}) async {
    try {
      //! GET ALL CONTACTS OF THE USER ON FIRESTORE.
      QuerySnapshot<Map<String, dynamic>> userCollection =
          await firebaseFirestore.collection("users").get();

      //! IS CONTACT FOUND
      bool isContactFound = false;
      for (QueryDocumentSnapshot<Map<String, dynamic>> contactDocument
          in userCollection.docs) {
        //! HOLD CONTACT DATA
        UserModel contactData = UserModel.fromJSON(contactDocument.data());

        //! REPLACE ALL SPACES IN THE USER PHONE CONTACTS
        String selectedPhoneNum =
            selectedContact.phones[0].number.replaceAll(" ", "");

        //! SET IS CONTACT FOUND
        if (selectedPhoneNum == contactData.phoneNum) {
          isContactFound = true;

          //! NAVIGATE TO CHAT SCREEN AND PASS IN NEEDED ARGUMENTS FOR UPDATES.
          AppNavigator.navigateToReplacementPage(
              thePageRouteName: AppRoutes.chatScreen,
              context: theContext,
              arguments: contactDocument.data());
        }
      }

      //! IF CONTACT IS NOT FOUND
      if (!isContactFound) {
        AppFunctionalUtils.showSnackBar(
            theBuildContext: theContext, theContent: "Contact not found");
      }
    } catch (exception) {
      AppFunctionalUtils.showSnackBar(
          theBuildContext: theContext, theContent: exception.toString());
    }
  }
}
