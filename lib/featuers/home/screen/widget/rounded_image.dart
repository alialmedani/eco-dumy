 
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.apllyImageRadius = true,
    this.border,
    this.backGroundColor = AppColors.lighta,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetWorkImage = false,
    this.onPressed,
    this.borderRaduis = AppPaddingSize.padding_16, 
  });

  final double? width, height;
  final String imageUrl;
  final bool apllyImageRadius;
  final BoxBorder? border;
  final Color backGroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetWorkImage;
  final VoidCallback? onPressed;
  final double borderRaduis;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backGroundColor,
          borderRadius: BorderRadius.circular(borderRaduis),
        ),
        child: ClipRRect(
          borderRadius: apllyImageRadius
              ? BorderRadius.circular(borderRaduis)
              : BorderRadius.zero,
          child: Image(
            fit: fit,
            image: isNetWorkImage
                ? NetworkImage(imageUrl)
                : AssetImage(imageUrl) as ImageProvider,
          ),
        ),
      ),
    );
  }
}
