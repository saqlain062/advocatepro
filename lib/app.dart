import 'package:advocatepro_f/screens/Forms/form_screen.dart';
import 'package:advocatepro_f/screens/authenticate/screens/password_configuration/forgot_password.dart';
import 'package:advocatepro_f/screens/authenticate/screens/onboarding/onboarding.dart';
import 'package:advocatepro_f/screens/authenticate/screens/signin/sign_in.dart';
import 'package:advocatepro_f/screens/authenticate/screens/signup/sign_up.dart';
import 'package:advocatepro_f/screens/bottom/advocate_screen.dart';
import 'package:advocatepro_f/screens/bottom/inbox_screen.dart';
import 'package:advocatepro_f/screens/bottom/profile_screen.dart';
import 'package:advocatepro_f/screens/home/home_client_screen.dart';
import 'package:advocatepro_f/screens/home/home_screen.dart';
import 'package:advocatepro_f/screens/home/home_screen_designe.dart';
import 'package:advocatepro_f/screens/home/upload_image.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,

      /// Show Loader or Circular Progress Indicator meanwhilte Authentication Repository is deciding to show relevent screen.
      home: const Scaffold(
        backgroundColor: SColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),

      title: 'My App',
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
      },
    );
  }
}
