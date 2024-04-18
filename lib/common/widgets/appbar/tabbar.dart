import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/device/device_utility.dart';
import 'package:advocatepro_f/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class STabBar extends StatelessWidget implements PreferredSizeWidget{
  const STabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? SColors.black : SColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: SColors.primary,
        labelColor: dark ? SColors.white : SColors.black,
        unselectedLabelColor: SColors.darkGrey,
      ),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(SDeviceUtils.getAppBarHeight());
}