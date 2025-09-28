import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 
class ProductDescriptionSection extends StatelessWidget {
  final String description;

  const ProductDescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    // final textStyles = TextStyles(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description".tr(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        const SizedBox(height: 8),
        Text(description),
      ],
    );
  }
}
