import 'package:advocatepro_f/features/authenticate/screens/onboarding/onboarding.dart';
import 'package:advocatepro_f/features/authenticate/screens/signin/sign_in.dart';
import 'package:advocatepro_f/features/authenticate/screens/signup/verify_email.dart';
import 'package:advocatepro_f/features/home/lawyer_navigation_menu_.dart';
import 'package:advocatepro_f/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:advocatepro_f/utils/exceptions/firebase_exceptions.dart';
import 'package:advocatepro_f/utils/exceptions/format_exceptions.dart';
import 'package:advocatepro_f/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to Show Relevant Screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const LawyerNavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: user.email,));
      }
    } else {
      // Locat Storage
      deviceStorage.writeIfNull("IsFirstTime", true);
      deviceStorage.read("IsFirstTime") != true
          ? Get.offAll(() => const SignIn())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  /* ------------------------------- Email & Password sign-in -----------------------------------*/

  /// - SignIn
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, Please try agian";
    }
  }
  /// - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, Please try agian";
    }
  }

  /// Mail Verification
  Future<void> sendEmailVerification() async {
    try {
      return await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, Please try agian";
    }
  }

  /* ------------------------------- Email & Password sign-in -----------------------------------*/

  /* ------------------------------- Email & Password sign-in -----------------------------------*/
  /// [LogoutUser] - Valid for any authernticaiton
    Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const SignIn());
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, Please try agian";
    }
  }
}
