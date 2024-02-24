
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SOutlineButtonTheme{
  SOutlineButtonTheme._();

  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: SColors.dark,
      side: const BorderSide(color: SColors.primary),
      textStyle: const TextStyle(fontSize: SSizes.fontSizeMd, color: SColors.dark, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    )
  );

    static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: SColors.white,
      side: const BorderSide(color: SColors.primary),
      textStyle: const TextStyle(fontSize: SSizes.fontSizeMd, color: SColors.white, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    )
  );
}