import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndCondationsText extends StatelessWidget {
  const TermsAndCondationsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "By_logging_you_agree_to_our".tr(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              // color: isDark ? ColorsManager.light : ColorsManager.gray,
              color: AppColors.lighta,
            ),
          ),
          TextSpan(
            text: "Terms_Conditions".tr(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              // color: isDark ? ColorsManager.light : ColorsManager.darkBlue,
              color: AppColors.lighta,
            ),
          ),
          TextSpan(
            text: "and".tr(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              height: 1.5,
              // color: isDark ? ColorsManager.light : ColorsManager.gray,
              color: AppColors.lighta,
            ),
          ),
          TextSpan(
            text: "Privacy_Policy".tr(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              // color: isDark ? ColorsManager.light : ColorsManager.darkBlue,
              color: AppColors.lighta,
            ),
          ),
        ],
      ),
    );
  }
}
