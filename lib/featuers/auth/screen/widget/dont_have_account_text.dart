import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/utils/Navigation/navigation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "Dont_have_an_account".tr(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lighta,
            ),
          ),
          TextSpan(
            text: "Sign_Up".tr(),
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              // color: isDark ? ColorsManager.light : ColorsManager.mainBlue,
              color: AppColors.lighta,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigation.pushReplacement(SignUpS)
              },
          ),
        ],
      ),
    );
  }
}
