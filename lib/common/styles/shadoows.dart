
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:flutter/material.dart';

class SShadowStyle {
  static final verticallawyerShadow = BoxShadow(
    color: SColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );

  static final horizontallawyerShadow = BoxShadow(
    color: SColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );
  
}

