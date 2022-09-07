import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti_whatsapp_clone/models/user_model.dart';
import 'package:serti_whatsapp_clone/repository/auth_repository.dart';

//! CONTROLLER PROVIDERS
final authControllerProvider = Provider((ref) {
  //! THE BELOW IS SIMILAR TO PROVIDER.OF<TYPE>(CONTEXT);
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(
      authRepository: authRepository, authControllerProviderRef: ref);
});

final userDataProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.fetchUserData();
});

//! CONTROLLER CLASS
class AuthController {
  final AuthRepository authRepository;
  final ProviderRef authControllerProviderRef;

  AuthController(
      {required this.authRepository, required this.authControllerProviderRef});

  Future<UserModel?> fetchUserData() async =>
      await authRepository.fetchCurrentUserData();

  //! USER DATA STREAM
  Stream<UserModel> userDataStream({required String userPhoneNumber}) =>
      authRepository.userDataStream(userPhoneNumber: userPhoneNumber);

  //! SIGN IN WITH PHONE NUMBER
  Future<void> signInWithPhone(
          {required BuildContext theBuildContext,
          required String phoneNumber}) async =>
      {
        log("Auth controller Sign-in with Phone Number triggered"),
        authRepository.signInWithPhone(
            context: theBuildContext, userPhoneNumber: phoneNumber)
      };

  //! VERIFY OTP
  Future<void> verifyOTP(
          {required BuildContext theBuildContext,
          required String verificationID,
          required String userOTP}) async =>
      {
        log("Auth controller Verify OTP triggered"),
        await authRepository.verifyOTP(
            theBuildContext: theBuildContext,
            userVerificationID: verificationID,
            userOTP: userOTP)
      };

  //! SAVE USER DATA.
  Future<void> saveUserDataToFirestore(
          {required File? profilePicture,
          required String userName,
          required BuildContext theBuildContext}) async =>
      {
        log("Auth controller Save user data triggered"),
        await authRepository.saveUserDataToFirestore(
            userName: userName,
            profilePicture: profilePicture,
            providerRef: authControllerProviderRef,
            theBuildContext: theBuildContext)
      };
}
