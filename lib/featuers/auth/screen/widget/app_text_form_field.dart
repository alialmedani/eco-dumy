 
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPaddaing;
  final InputBorder? focouseBorder;
  final InputBorder? enableBorder;
  final TextStyle? inputTextSytle;
  final TextStyle? hintSytle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // ✅ صارت optional

  const AppTextFormField({
    super.key,
    this.contentPaddaing,
    this.focouseBorder,
    this.enableBorder,
    this.inputTextSytle,
    this.hintSytle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        //default padding ll text
        isDense: true,
        contentPadding:
            contentPaddaing ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        focusedBorder:
            focouseBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.mainBluea,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
        enabledBorder:
            enableBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.lighterGreya,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(16.0),
        ),
        hintStyle: hintSytle ??TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.lightGraya,
  ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? AppColors.moreLightGreya,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style:TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.darkBluea,
  ),
      validator: validator,
    );
  }
}
