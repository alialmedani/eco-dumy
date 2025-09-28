import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductTitlePriceWidget extends StatelessWidget {
  final String title;
  final double price;

  const ProductTitlePriceWidget({
    super.key,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        Text(
          '${"Price".tr()} ${price.toStringAsFixed(2)}\$',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.mainBluea,
          ),
        ),
      ],
    );
  }
}
