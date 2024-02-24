

import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SAppBarTheme{
  SAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: colorAppbarIcon, size: SSizes.iconMedium),
    actionsIconTheme: IconThemeData(color: colorAppbarIcon, size: SSizes.iconMedium),
    titleTextStyle: TextStyle(fontSize: SSizes.fontSizeLg, fontWeight: FontWeight.w600, color: SColors.dark
    )
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: SColors.icondark, size: SSizes.iconMedium),
    actionsIconTheme: IconThemeData(color: SColors.iconColorin, size: SSizes.iconMedium),
    titleTextStyle: TextStyle(fontSize: SSizes.fontSizeLg, fontWeight: FontWeight.w600, color: SColors.textWhite
    )
  );
}