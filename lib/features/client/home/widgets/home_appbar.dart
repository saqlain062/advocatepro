import 'package:advocatepro_f/common/widgets/appbar/appbar.dart';
import 'package:advocatepro_f/features/client/home/home.dart';
import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';

class SHomeAppBarClient extends StatelessWidget {
  const SHomeAppBarClient({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SAppBar(
      title: Text(STexts.homeAppbarTitle,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: SColors.white)),
      actions: [SNotificationCounterIcon(onPressed: () {  },)],
    );
  }
}