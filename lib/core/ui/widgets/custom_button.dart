import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/text_styles/app_text_style.dart';
import 'package:eco_dumy/core/constant/text_styles/font_size.dart';
import 'package:flutter/material.dart';
 

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.w,
    this.color,
    required this.text,
    this.textStyle,
    this.h,
    this.radius,
    this.borderSideColor,
    this.rowChild,
    this.onPressed,
    this.isEnabled = true,
  });

  final double? w;
  final double? radius;
  final double? h;
  final Color? color;
  final Color? borderSideColor;
  final TextStyle? textStyle;
  final String? text;
  final Widget? rowChild;
  final VoidCallback? onPressed;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onPressed : null,
      child: AbsorbPointer(
        absorbing: !isEnabled,
        child: Container(
          height: h ?? 48,
          width: w ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 8),
            color: isEnabled ? (color ?? AppColors.primary) : Colors.grey,
            border: Border.all(
              color: borderSideColor ?? Colors.transparent,
            ),
          ),
          child: (rowChild != null)
              ? rowChild!
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        text!,
                        style: textStyle ??
                            AppTextStyle.getMediumStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryColor,
                                fontSize: AppFontSize.size_16),
                        textAlign: (rowChild != null)
                            ? TextAlign.start
                            : TextAlign.center,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
