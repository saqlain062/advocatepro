import 'package:advocatepro_f/utils/constants/color.dart';
import 'package:advocatepro_f/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// A widget for displaying on animated loading indicator with optimal text and action button.
class SAnimationLoaderWidget extends StatelessWidget {
  /// Default constructor for the SAnimationLoaderWidget.
  /// 
  /// Parameters:
  ///   - text: The text to be displayed below the animation.
  ///   - animation: Teh path to the lottie animation file.
  ///   - showAction: Whether to show on action button below the text.
  ///   - actionText: The text to be displayed on the action button.
  ///   - onActionPressed: Callback function to be executed when the action button is pressed,
  const SAnimationLoaderWidget(
      {super.key,
      required this.text,
      required this.animation,
      this.showAction = false,
      this.actionText,
      this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8), // Display Lottie animaiton
          const SizedBox(height: SSizes.defaultSpaces,),
          Text(text,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,),
          const SizedBox(height: SSizes.defaultSpaces,),
          showAction ? SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style: OutlinedButton.styleFrom(backgroundColor: SColors.dark),
              child: Text(
                actionText!,
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: SColors.light),
              ),
            ),
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
