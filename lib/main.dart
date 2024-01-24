import 'dart:io' show Platform;
import 'package:advocatepro_f/screens/Forms/form_screen.dart';
import 'package:advocatepro_f/screens/authenticate/sign_in.dart';
import 'package:advocatepro_f/screens/authenticate/sign_up.dart';
import 'package:advocatepro_f/screens/bottom/advocate_screen.dart';
import 'package:advocatepro_f/screens/bottom/inbox_screen.dart';
import 'package:advocatepro_f/screens/bottom/profile_screen.dart';
import 'package:advocatepro_f/screens/home/home_screen.dart';
import 'package:advocatepro_f/screens/home/home_screen_designe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyCw2fUzwUnNEuUMAgIcf0FzwxBCMhqTZuI',
              appId: '1:189944227194:android:b8c7b4de40d70eb0c022c3',
              messagingSenderId: '189944227194',
              projectId: 'advocate-d26b5'))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: SignIn.id,
      routes: {
        SignIn.id : (context) => const SignIn(),
        SignUpScreen.id :(context) => const SignUpScreen(),
        HomeScreen.id : (context) => const HomeScreen(),
        HomeScreenDesgine.id :(context) => const HomeScreenDesgine(),
        AdvocateScreen.id :(context) => const AdvocateScreen(),
        FormScreen.id : (context) => const FormScreen(),
        InboxScreen.id :(context) => const InboxScreen(),
        ProfileScreen.id :(context) => const ProfileScreen(),
        // Add more routes as needed
      },
    );
  }
}
