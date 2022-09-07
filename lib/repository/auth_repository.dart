// ignore_for_file: use_build_context_synchronously
//! IN THIS REPO, USER DATA IS BEING SAVED TO FIRESTORE, IN THE COLLECTIONS "USERS"
//! USING THE USERS PHONE NUMBER ...AS THE DOCUMENT ID
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti_whatsapp_clone/models/user_model.dart';
import 'package:serti_whatsapp_clone/repository/firebase_storage_repository.dart';
import 'package:serti_whatsapp_clone/router/routes.dart';
import 'package:serti_whatsapp_clone/screens/home/home_screen.dart';
import 'package:serti_whatsapp_clone/utils/app_functional_utils.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    firebaseFirestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRepository({required this.firebaseAuth, required this.firebaseFirestore});

  //! METHODS
  //! FETCH CURRENT USER
  Future<UserModel?> fetchCurrentUserData() async {
    //! CREATE MODEL
    UserModel? user;

    //! GET USER DOCUMENT SNAPSHOT
    DocumentSnapshot<Map<String, dynamic>> userData = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.phoneNumber)
        .get();

    //! MAP TO OUR USER MODEL
    if (userData.data() != null) {
      user = UserModel.fromJSON(userData.data()!);
    }

    return user;
  }

  //! USER DATA STREAM - FETCH DOCUMENT BY USER PHONE NUMBER
  Stream<UserModel> userDataStream({required String userPhoneNumber}) =>
      firebaseFirestore
          .collection("users")
          .doc(userPhoneNumber)
          .snapshots()
          .map((event) => UserModel.fromJSON(event.data()!));

  //! SIGN IN WITH PHONE
  Future<void> signInWithPhone(
      {required BuildContext context, required String userPhoneNumber}) async {
    try {
      //! VERIFY NUMBER
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: userPhoneNumber,

          //! ON VERIFICATION COMPLETED
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async => {
                    //! ALERT VERIFICATION COMPLETED.
                    log("Verification Completed!"),
                    AppFunctionalUtils.showSnackBar(
                        theBuildContext: context,
                        theContent: "Verification Completed"),

                    //! ALERT SIGNING IN.
                    log("Signing user in"),
                    AppFunctionalUtils.showSnackBar(
                        theBuildContext: context, theContent: "Signing You in"),

                    //! SIGN IN.
                    await firebaseAuth.signInWithCredential(phoneAuthCredential)
                  },

          //! ON VERIFICATION FAILED
          verificationFailed: (error) => {
                //! ALERT VERIFICATION FAILED
                log("Verification failed! Code: ${error.code} Reason: ${error.message}"),

                //! NOTIFY USERS
                AppFunctionalUtils.showSnackBar(
                    theBuildContext: context,
                    theContent:
                        "Verification failed! Reason: ${error.message}"),

                //! THROW EXCEPTION

                throw Exception(error.message)
              },

          //! ON CODE SENT
          codeSent: (verificationId, forceResendingToken) async => {
                //! ALERT VERIFICATION FAILED
                log("Code sent! Code: $verificationId "),

                //! NOTIFY USERS
                AppFunctionalUtils.showSnackBar(
                    theBuildContext: context,
                    theContent: "Verification code sent"),

                //! PUSH TO NEXT PAGE
                Navigator.pushNamed(context, AppRoutes.otpScreen,
                    arguments: verificationId)
              },

          //! RETRIEVAL TIME OUT
          codeAutoRetrievalTimeout: (String verificationID) {});
    } on FirebaseAuthException catch (exception) {
      log("Firebase Exception from Auth Repository: ${exception.message}");
      AppFunctionalUtils.showSnackBar(
          theBuildContext: context, theContent: exception.message!);
    }
  }

  //! VERIFY OTP
  Future<void> verifyOTP(
      {required BuildContext theBuildContext,
      required String userVerificationID,
      required String userOTP}) async {
    try {
      //! CREATE PHONE AUTH CREDENTIAL USING USER VERIFICATION ID AND RECEIVED TOKEN
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: userVerificationID, smsCode: userOTP);

      //! SIGN IN
      await firebaseAuth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
          theBuildContext, AppRoutes.userInformationScreen, (route) => false);
    } on FirebaseAuthException catch (exception) {
      log("Firebase Exception from Auth Repository: ${exception.message}");
      AppFunctionalUtils.showSnackBar(
          theBuildContext: theBuildContext, theContent: exception.message!);
    }
  }

  //! SAVE USER DATA TO FIRESTORE USING PHONE NUMBER FOR USER DOCUMENT ID
  //! ADD THE USER DOCUMENT INTO THE COLLECTION "USERS"
  Future<void> saveUserDataToFirestore(
      {required String userName,
      required File? profilePicture,
      required ProviderRef providerRef,
      required BuildContext theBuildContext}) async {
    try {
      String photoURL = "";
      String userPhoneNum = firebaseAuth.currentUser!.phoneNumber!;
      if (profilePicture != null) {
        photoURL = await providerRef
            .read(firebaseStorageRepositoryProvider)
            .addFileToFirebaseStorage(
                storageRef: "profilePictures/$userPhoneNum ",
                file: profilePicture);
      }

      //! CREATE USER MODEL
      UserModel user = UserModel(
          userName: userName,
          userID: firebaseAuth.currentUser!.uid,
          profilePicture: photoURL,
          phoneNum: userPhoneNum,
          isUserOnline: true,
          userGroupID: []);

      //! ADD DATA TO FIRESTORE
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.phoneNumber)
          .set(user.toJSON());

      //! NAVIGATE TO NEXT SCREEN
      Navigator.pushAndRemoveUntil(
          theBuildContext,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    } catch (exception) {
      log("Firebase Exception from Auth Repository - saveUserDataToFirestore: ${exception.toString()}");
      AppFunctionalUtils.showSnackBar(
          theBuildContext: theBuildContext, theContent: exception.toString());
    }
  }
}
