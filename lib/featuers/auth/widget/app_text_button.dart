import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPaddaing;
  final double? verticalPaddaing;
  final double? buttonWidth;
  final double? buttonhight;
  final String buttonText;
  final TextStyle textStyle;
  final VoidCallback? onPressed; // ✅ صار اختياري

  const AppTextButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPaddaing,
    this.verticalPaddaing,
    this.buttonWidth,
    this.buttonhight,
    required this.buttonText,
    required this.textStyle,
    this.onPressed, // ✅ صار اختياري
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          backgroundColor ?? AppColors.mainBlue,
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: horizontalPaddaing?.w ?? 12.w,
            vertical: verticalPaddaing?.h ?? 14.h,
          ),
        ),
        fixedSize: MaterialStateProperty.all(
          Size(buttonWidth?.w ?? double.maxFinite, buttonhight ?? 50.h),
        ),
      ),
      onPressed: onPressed, // لو null، CreateModel رح يتعامل مع الضغط
      child: Text(buttonText, style: textStyle),
    );
  }
}
