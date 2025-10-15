import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/boilerplate/create_model/widgets/create_model.dart';
import 'package:eco_dumy/core/classes/cashe_helper.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/utils/Navigation/navigation.dart';
import 'package:eco_dumy/featuers/auth/cubit/auth_cubit.dart';
import 'package:eco_dumy/featuers/auth/data/model/login_model.dart';
import 'package:eco_dumy/featuers/auth/screen/widget/dont_have_account_text.dart';
import 'package:eco_dumy/featuers/auth/screen/widget/email_and_password.dart';
import 'package:eco_dumy/featuers/auth/screen/widget/spacing.dart';
import 'package:eco_dumy/featuers/auth/screen/widget/terms_and_condations_text.dart';
import 'package:eco_dumy/featuers/auth/widget/app_text_button.dart';
import 'package:eco_dumy/featuers/home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen1 extends StatelessWidget {
  const LoginScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darka,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome_back".tr(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.lighta,
                  ),
                ),
                verticalSpace(8),
                Text(
                  "Were_excited_to_have_you_back".tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lighta,
                  ),
                ),
                verticalSpace(36),
                const EmailAndPassword(),
                verticalSpace(70),

                // ✅ الزر مربوط مع CreateModel
                CreateModel<LoginModel>(
                  useCaseCallBack: (model) async {
                    return context.read<AuthCubit>().login();
                  },
                  onSuccess: (LoginModel res) async {
                    await CacheHelper.setToken(res.accessToken);
                    await CacheHelper.setRefreshToken(res.refreshToken);
                    await CacheHelper.setUserInfo(res);
                    Navigation.pushAndRemoveUntil(HomeScreen());
                  },
                  withValidation: false,
                  onError: (message) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(message.toString())));
                  },
                  child: AppTextButton(
                    buttonText: "Login".tr(),
                    textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lighta,
                    ),
                    onPressed: null, // ✅ صار مقبول
                  ),
                ),

                verticalSpace(16),
                const TermsAndCondationsText(),
                verticalSpace(60),
                const DontHaveAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
