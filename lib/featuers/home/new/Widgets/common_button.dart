import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTab;
  const CommonButton({super.key, required this.title, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.xprimaryColor,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTab,
        child: SizedBox(
          height: 55,
          width: double.infinity,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
