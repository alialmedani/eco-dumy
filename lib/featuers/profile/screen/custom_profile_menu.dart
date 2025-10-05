 
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenu extends StatelessWidget {
  final String text, icon;
  final VoidCallback press;

  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    // final dark = HelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: 
          // dark
          //     ? ColorsManager.darkerGrey
          //     : ColorsManager.light,
          AppColors.darkerGreya,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(icon, color: AppColors.mainBluea, width: 22),
            // horizontalSpace(20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, color: AppColors.graya),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
