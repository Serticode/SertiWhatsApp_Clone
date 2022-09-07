import 'package:flutter/material.dart';
import 'package:serti_whatsapp_clone/models/user_model.dart';
import 'package:serti_whatsapp_clone/router/routes.dart';
import 'package:serti_whatsapp_clone/screens/auth/login/login_screen.dart';
import 'package:serti_whatsapp_clone/screens/auth/otp/otp_screen.dart';
import 'package:serti_whatsapp_clone/screens/auth/user_info_screen/user_info_screen.dart';
import 'package:serti_whatsapp_clone/screens/contact/select_contacts_screen.dart';
import 'package:serti_whatsapp_clone/screens/home/home_screen.dart';
import 'package:serti_whatsapp_clone/screens/chat/chat_screen.dart';

class AppNavigator {
  //! NAVIGATE TO A PAGE WITHOUT REPLACING THE PREVIOUS PAGE.
  static void navigateToPage(
          {required String thePageRouteName, required BuildContext context}) =>
      Navigator.of(context).pushNamed(thePageRouteName);

  //! NAVIGATE TO A PAGE AND REPLACE THE PREVIOUS PAGE
  static void navigateToReplacementPage(
          {required String thePageRouteName,
          required BuildContext context,
          Object? arguments}) =>
      Navigator.of(context)
          .pushReplacementNamed(thePageRouteName, arguments: arguments);

  //! ROUTE GENERATOR
  static Route<dynamic> generateRoute({required RouteSettings routeSettings}) {
    switch (routeSettings.name) {
      //! SIGN IN
      case AppRoutes.signInRoute:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const LoginScreen());

      //! OTP
      case AppRoutes.otpScreen:
        final verificationID = routeSettings.arguments as String;
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: OTPScreen(verificationID: verificationID));

      //! USER INFORMATION SCREEN
      case AppRoutes.userInformationScreen:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const UserInformationScreen());

      //! HOME SCREEN
      case AppRoutes.homeScreenRoute:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const HomeScreen());

      //! SELECT CONTACTS SCREEN
      case AppRoutes.selectContactsScreen:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const SelectContactsScreen());

      //! CHAT SCREEN
      case AppRoutes.chatScreen:
        final UserModel userDetailsFromArguments =
            UserModel.fromJSON(routeSettings.arguments as Map<String, dynamic>);
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: ChatScreen(theUserDetails: userDetailsFromArguments));

      //! DEFAULT
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child:
                        Text('No route defined for ${routeSettings.name}'))));
    }
  }
}

//! GET A PAGE ROUTE
PageRoute _getPageRoute({String? routeName, Widget? view, Object? args}) {
  return MaterialPageRoute(
      settings: RouteSettings(name: routeName, arguments: args),
      builder: (_) => view!);
}
