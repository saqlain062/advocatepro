import 'package:advocatepro_f/screens/authenticate/screens/onboarding/onboarding.dart';
import 'package:advocatepro_f/screens/authenticate/screens/signin/sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();

  /// Called from main.dart on app launch
  @override
  void onReady(){
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to Show Relevant Screen
  screenRedirect() async {
    // Locat Storage
    if(kDebugMode){
      print("=================== GET STORAGE Auth Repo =====================================");
      print(deviceStorage.read("IsFirstTime"));
    }
    
    deviceStorage.writeIfNull("IsFirstTime", true);
    deviceStorage.read("IsFirstTime") != true ? Get.offAll(() => const SignIn()) : Get.offAll(const OnBoardingScreen());

  }
  
  /* ------------------------------- Email & Password sign-in -----------------------------------*/




  
  /* ------------------------------- Email & Password sign-in -----------------------------------*/




  
  /* ------------------------------- Email & Password sign-in -----------------------------------*/
} 