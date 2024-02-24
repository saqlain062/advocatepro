
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:flutter/material.dart';

class SChipTheme {
  SChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: SColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: SColors.dark),
    selectedColor: SColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: SColors.grey,
    labelStyle: TextStyle(color: SColors.white),
    selectedColor: SColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: Colors.white
  );
}