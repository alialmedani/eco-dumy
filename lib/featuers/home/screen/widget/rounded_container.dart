 
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:flutter/material.dart';

class RoundedContainar extends StatelessWidget {
  const RoundedContainar({
    super.key,
    this.width,
    this.height,
    this.radius = AppPaddingSize.padding_16,
    this.child,
    this.showBordere = false,
    this.backGroundColor = AppColors.white,
    this.borderColor = AppColors.kPrimaryColor2a,
    this.padding,
    this.margin,
  });
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBordere;
  final Color backGroundColor;
  final Color borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBordere ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
