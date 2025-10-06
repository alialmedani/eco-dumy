import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.textColor,
    this.titleStyle,
    this.showActionButton = true,
    required this.title,
    this.buttonTitle = 'View_All',
    this.onPressed,
  });

  final Color? textColor;
  final TextStyle? titleStyle;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
              titleStyle ??
              Theme.of(context).textTheme.titleLarge!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style:
                  titleStyle ??
                  Theme.of(
                    context,
                  ).textTheme.bodySmall!.apply(color: textColor),
            ),
          ),
      ],
    );
  }
}
