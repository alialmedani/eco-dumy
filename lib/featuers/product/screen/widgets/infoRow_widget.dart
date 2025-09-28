import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoRowWidget extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const InfoRowWidget({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14.sp,
                color: valueColor ?? Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RatingRowWidget extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const RatingRowWidget({
    super.key,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          rating.round(),
          (index) => const Icon(Icons.star, color: Colors.amber, size: 18),
        ),
        ...List.generate(
          5 - rating.round(),
          (index) =>
              const Icon(Icons.star_border, color: Colors.grey, size: 18),
        ),
        SizedBox(width: 8.w),
        Text(
          '($reviewCount ${"reviews".tr()})',
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }
}

class ReviewTileWidget extends StatelessWidget {
  final ReviewModel review;

  const ReviewTileWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(review.reviewerName),
      subtitle: Text(
        review.comment,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          // color: isDark ? ColorsManager.darkGrey : ColorsManager.gray,
          color: AppColors.darkGreya,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          review.rating,
          (i) => const Icon(Icons.star, size: 16, color: Colors.amber),
        ),
      ),
    );
  }
}
