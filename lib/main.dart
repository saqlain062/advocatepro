import 'dart:io' show Platform;
import 'package:advocatepro_f/app.dart';
import 'package:advocatepro_f/data/repositories/authentication/authentication_repository.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:advocatepro_f/utils/constants/api_constants.dart';

Future main() async {
  /// -- Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// -- GetX Local Storage
  await GetStorage.init();

  /// -- Await Splash until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// -- Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

 
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: apiKey,
          appId: appId,
          messagingSenderId: messagingSenderId,
          projectId: projectId,
          storageBucket: storageBucket,
        ))
      : await Firebase.initializeApp();

  // Load all the Material Design / Themes / Localizations / Bindings
  runApp(const MyApp());
}
