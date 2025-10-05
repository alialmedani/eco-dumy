 import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String imageUrl;
  final String username;

  const ProfilePic({super.key, required this.imageUrl, required this.username});

  @override
  Widget build(BuildContext context) {
    // final dark = HelperFunctions.isDarkMode(context);

    return SizedBox(
      height: 85,
      width: 85,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl)
                : null,
            backgroundColor:
            //  dark
            //     ? ColorsManager.darkerGrey
            //     : ColorsManager.light,
            AppColors.darkerGreya,
            child: imageUrl.isEmpty
                ? Text(
                    username[0].toUpperCase(),
                    style: const TextStyle(fontSize: 40, color: Colors.black),
                  )
                : null,
          ),
          // Positioned(
          //   bottom: 0,
          //   right: -10,
          //   child: Container(
          //     height: 30,
          //     width: 30,
          //     decoration: BoxDecoration(
          //       color: ColorsManager.mainBlue,
          //       shape: BoxShape.circle,
          //       border: Border.all(width: 2, color: Colors.white),
          //     ),
          //     child: const Icon(
          //       Icons.camera_alt,
          //       color: Colors.white,
          //       size: 16,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
