
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

/// Custom Class for Light & dark themes

class SCheckBoxTheme {
  SCheckBoxTheme._();
  /// Customizable Light Text theme
  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SSizes.borderRadiusSm)),
    checkColor: MaterialStateProperty.resolveWith((states){
      if(states.contains(MaterialState.selected)){
        return SColors.white;
      } else {
        return SColors.dark;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states){
      if(states.contains(MaterialState.selected)){
        return SColors.primary;
      } else {
        return Colors.transparent;
      }
    }
    )
  );
  
  /// Customizable Light Text theme
  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SSizes.borderRadiusSm)),
    checkColor: MaterialStateProperty.resolveWith((states){
      if(states.contains(MaterialState.selected)){
        return SColors.white;
      } else {
        return SColors.dark;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states){
      if(states.contains(MaterialState.selected)){
        return SColors.primary;
      } else {
        return Colors.transparent;
      }
    }
    )
  );
}