import 'package:advocatepro_f/data/repositories/user/user_repository.dart';
import 'package:advocatepro_f/features/authenticate/screens/onboarding/onboarding.dart';
import 'package:advocatepro_f/features/authenticate/screens/signin/sign_in.dart';
import 'package:advocatepro_f/features/authenticate/screens/signup/verify_email.dart';
import 'package:advocatepro_f/features/personalization/models/user_model.dart';
import 'package:advocatepro_f/lawyer_navigation_menu_.dart';
import 'package:advocatepro_f/navigation_client_menu.dart';
import 'package:advocatepro_f/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:advocatepro_f/utils/exceptions/firebase_exceptions.dart';
import 'package:advocatepro_f/utils/exceptions/format_exceptions.dart';
import 'package:advocatepro_f/utils/exceptions/platform_exceptions.dart';
import 'package:advocatepro_f/utils/local_storage/storage_utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser;

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
      try {
        await user.reload(); // Refresh user data from the server
        if (user.emailVerified) {
          // Initialize User Specific Storage
          await SLocalStorage.init(user.uid);

          // if ther user's email is verified, navigate to the main Navigation Menu
          if(await checkLawyer()){
           Get.offAll(() =>  const LawyerNavigationMenu());
          } else {
            Get.offAll( () => const NavigationClientMenu());
          }          
        } else {
          Get.offAll(() => VerifyEmailScreen(email: user.email));
        }
      } catch (e) {
        print('Error checking user status: $e');
        // Handle errors (e.g., user deleted) by redirecting to appropriate screens
        if (e is FirebaseAuthException && e.code == 'user-not-found') {
          // User doesn't exist, handle accordingly (e.g., show sign-in screen)
          Get.offAll(const SignIn());
        } else {
          // Other errors, handle accordingly (e.g., show error message)
          // Redirect to onboarding screen for demonstration purposes
          Get.offAll(const OnBoardingScreen());
        }
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

  Future<bool> checkLawyer() async {
    try {
      final snapshot = await _db.collection('Users').doc(_auth.currentUser?.uid).get();

      UserModel currentUser = UserModel.fromSnapshot(snapshot);
      if(currentUser.barID.isNotEmpty){
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'list Something went wrong. Please try again';
    }
  }

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

  /// [EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordRestEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
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

  /// [ReAuthentication] - FORGET PASSWORD
  Future<void> reAuthenticateEmailAndPasswordUser(
      String email, String password) async {
    try {
      // Create a credential
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      // ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
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
  /* ------------------------------- Federated identity & social sign-in -----------------------------------*/

  /// [GoogleAuthentication] Google
  Future<UserCredential?> siginWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      // Once signed in, return the User credential
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print('--------------------- Something went wrong: $e');
      return null;
    }
  }

  /* ------------------------------- Email & Password sign-in -----------------------------------*/
  /// [LogoutUser] - Valid for any authernticaiton
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
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

  /// Delete User - Remove user Auth and Firestore Account.
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
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
