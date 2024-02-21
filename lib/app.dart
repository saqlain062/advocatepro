import 'package:advocatepro_f/screens/Forms/form_screen.dart';
import 'package:advocatepro_f/screens/authenticate/forgot_password.dart';
import 'package:advocatepro_f/screens/authenticate/sign_in.dart';
import 'package:advocatepro_f/screens/authenticate/sign_up.dart';
import 'package:advocatepro_f/screens/bottom/advocate_screen.dart';
import 'package:advocatepro_f/screens/bottom/inbox_screen.dart';
import 'package:advocatepro_f/screens/bottom/profile/profile_edit_screen.dart';
import 'package:advocatepro_f/screens/bottom/profile_screen.dart';
import 'package:advocatepro_f/screens/home/home_client_screen.dart';
import 'package:advocatepro_f/screens/home/home_screen.dart';
import 'package:advocatepro_f/screens/home/home_screen_designe.dart';
import 'package:advocatepro_f/screens/home/upload_image.dart';
import 'package:advocatepro_f/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode:  ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      
      title: 'My App',
      initialRoute: SignIn.id,
      routes: {
        SignIn.id: (context) => const SignIn(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        UploadImage.id: (context) => const UploadImage(),
        HomeScreen.id: (context) => const HomeScreen(),
        ClientHomeScreen.id: (context) => const ClientHomeScreen(),
        HomeScreenDesgine.id: (context) => const HomeScreenDesgine(),
        AdvocateScreen.id: (context) => const AdvocateScreen(),
        FormScreen.id: (context) => const FormScreen(),
        InboxScreen.id: (context) => const InboxScreen(),
        ProfileScreen.id: (context) => const ProfileScreen(),
        ForgetPasswordScreen.id: (context) => const ForgetPasswordScreen(),
        ProfileEditScreen.id:(context) => const ProfileEditScreen(),
      },
    );
  }
}