 
import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyNowButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final ProductModel product;

  const BuyNowButtonWidget({
    super.key,
    required this.onPressed,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 25.h), // ← رفع الزر للأعلى

      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onPressed, // مباشرة بدون bottom sheet
          label: Text(
             "add_to_cart".tr(),
            // style: TextStyles(context).font16WhiteSemiBold(context),s
        style: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      // color: isDark ? ColorsManager.light : ColorsManager.white,
      color: AppColors.lighta
    ) ,  ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kPrimaryColor2a,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ),
    );
  }
}
