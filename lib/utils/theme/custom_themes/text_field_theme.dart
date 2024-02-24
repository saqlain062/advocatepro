
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class STextFormFieldTheme{
  STextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: SColors.iconColor,
    suffixIconColor: SColors.iconColor,
    labelStyle: const TextStyle().copyWith(fontSize: SSizes.fontSizeSm, color: SColors.dark),
    hintStyle: const TextStyle().copyWith(fontSize: SSizes.fontSizeSm, color: SColors.dark),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: SColors.dark.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: SColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: SColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: SColors.grey),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: SColors.error),
    ), 
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 2, color: SColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: SColors.iconColor,
    suffixIconColor: SColors.iconColor,
    labelStyle: const TextStyle().copyWith(fontSize: SSizes.fontSizeSm, color: SColors.white),
    hintStyle: const TextStyle().copyWith(fontSize: SSizes.fontSizeSm, color: SColors.white),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: SColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: SColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: SColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: SColors.grey),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 1, color: SColors.error),
    ), 
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SSizes.borderRadiusLg),
      borderSide: const BorderSide(width: 2, color: SColors.warning),
    ),
  );
}