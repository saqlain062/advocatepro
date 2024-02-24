import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/theme/custom_themes/appbar_theme.dart';
import 'package:advocatepro_f/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:advocatepro_f/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:advocatepro_f/utils/theme/custom_themes/chip_theme.dart';
import 'package:advocatepro_f/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:advocatepro_f/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:advocatepro_f/utils/theme/custom_themes/text_field_theme.dart';
import 'package:advocatepro_f/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class SAppTheme {
  SAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    primaryColor: SColors.primary,
    chipTheme: SChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    textTheme: STextTheme.lightTextTheme,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    checkboxTheme: SCheckBoxTheme.lightCheckboxTheme,
    bottomSheetTheme: SBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: SOutlineButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.lightInputDecorationTheme,
    
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    primaryColor: SColors.primary,
    chipTheme: SChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    textTheme: STextTheme.dartTextTheme,
    appBarTheme: SAppBarTheme.darkAppBarTheme,
    checkboxTheme: SCheckBoxTheme.darkCheckboxTheme,
    bottomSheetTheme: SBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: SOutlineButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.darkInputDecorationTheme,
    
  );
}