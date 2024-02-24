import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:flutter/material.dart';

class SElevatedButtonTheme{
  SElevatedButtonTheme._();
/// -- Light them
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: SColors.textinbox,
      backgroundColor: SColors.primary,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(color: SColors.primary,),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 16, color:  Colors.white
        , fontWeight: FontWeight.w600
      ), shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)),
      )

    );

  /// -- Dark Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: SColors.textinbox,
      backgroundColor: SColors.primary,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey,
      side: const BorderSide(color: SColors.primary,),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 16, color:  Colors.white
        , fontWeight: FontWeight.w600
      ), shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)),
      )

  );
}