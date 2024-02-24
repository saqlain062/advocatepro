
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:flutter/material.dart';

class SBottomSheetTheme{
  SBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: SColors.primaryBackground,
    modalBackgroundColor: SColors.primaryBackground,
    constraints: const BoxConstraints(minWidth: 
    double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
  );

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: SColors.dark,
    modalBackgroundColor: SColors.dark,
    constraints: const BoxConstraints(minWidth: 
    double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
  );
}