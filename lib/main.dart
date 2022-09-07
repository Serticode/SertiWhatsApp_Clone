import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serti_whatsapp_clone/controllers/auth_controller.dart';
import 'package:serti_whatsapp_clone/firebase_options.dart';
import 'package:serti_whatsapp_clone/router/router.dart';
import 'package:serti_whatsapp_clone/screens/error/error_screen.dart';
import 'package:serti_whatsapp_clone/screens/home/home_screen.dart';
import 'package:serti_whatsapp_clone/screens/landing/landing_screen.dart';
import 'package:serti_whatsapp_clone/screens/loading/loading_screen.dart';
import 'package:serti_whatsapp_clone/themes/theme.dart';

Future<void> main() async {
  //! ENSURE THE FLUTTER ENGINE IS INITIALIZED.
  WidgetsFlutterBinding.ensureInitialized();

  //! INITIALIZE FIREBASE PER PLATFORM
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: SertiWhatsappClone()));
}

class SertiWhatsappClone extends ConsumerWidget {
  const SertiWhatsappClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Serticode Whatsapp Clone",
      theme: AppTheme.theAppTheme,
      onGenerateRoute: (settings) =>
          AppNavigator.generateRoute(routeSettings: settings),
      home: ref.watch(userDataProvider).when(
          //! FETCHING USER DATA
          loading: () => const LoadingScreen(),

          //! USER DATA IS GOTTEN
          data: (theUser) =>
              theUser == null ? const LandingScreen() : const HomeScreen(),

          //! ERROR FETCHING DATA
          error: (error, stackTrace) =>
              ErrorScreen(theError: error.toString())));
}
