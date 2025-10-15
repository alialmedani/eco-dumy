import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/classes/cashe_helper.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:eco_dumy/core/constant/text_styles/font_size.dart';
import 'package:eco_dumy/core/utils/Navigation/navigation.dart';
import 'package:eco_dumy/featuers/auth/cubit/auth_cubit.dart';
import 'package:eco_dumy/featuers/auth/data/model/login_model.dart';
import 'package:eco_dumy/featuers/auth/screen/login_screen.dart';
import 'package:eco_dumy/featuers/auth/screen/widget/ll.dart';
import 'package:eco_dumy/featuers/profile/screen/account_page.dart';
import 'package:eco_dumy/featuers/profile/screen/custom_profile_menu.dart';
import 'package:eco_dumy/featuers/profile/screen/custom_profile_pic.dart';
import 'package:eco_dumy/featuers/root/screen/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            ProfilePic(
              imageUrl: CacheHelper.userInfo?.image ?? "",
              username: CacheHelper.userInfo?.firstName ?? "",
            ),
            SizedBox(height: 25.h),
            ProfileMenu(
              text: "My_Account".tr(),
              icon: "assets/icons/User Icon.svg",
              press: () {
                Navigation.pushAndRemoveUntil(const AccountPage());
              },
            ),
            ProfileMenu(
              text: "My_Orders".tr(),
              icon: "assets/icons/Cart Icon.svg",
              press: () {
                // context.read<NavigationCubit>().onIconTap(1);
              },
            ),
            ProfileMenu(
              text: "Favorites".tr(),
              icon: "assets/icons/Heart Icon.svg",
              press: () {
                // context.read<NavigationCubit>().onIconTap(2);
              },
            ),
            ProfileMenu(
              text: "Order_History".tr(),
              icon: "assets/icons/history_svgrepo.svg",
              press: () {
                // Navigator.pushNamed(context, Routes.ordersHistoryPage);
              },
            ),
            ProfileMenu(
              text: "Change_Theme".tr(),
              icon: "assets/icons/dark_mode.svg",
              press: () {
                // context.read<ThemeCubit>().toggleTheme();
              },
            ),
            ProfileMenu(
              text: "Change_Language".tr(),
              icon: "assets/icons/language.svg",
              press: () {
                // Navigator.pushNamed(context, Routes.changeLanguageScreen);
              },
            ),
            ProfileMenu(
              text: "Log_Out".tr(),
              icon: "assets/icons/Log_out.svg",
              press: () {
                CacheHelper.box.clear();
                Navigation.pushAndRemoveUntil(LoginScreen1());
                // Navigator.pushReplacementNamed(
                //   context,
                //   Routes.loginScreen,
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
