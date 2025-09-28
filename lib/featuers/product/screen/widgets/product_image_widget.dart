import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductImageWidget extends StatelessWidget {
  final String imageUrl;

  const ProductImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
          bottom: Radius.circular(16.r),
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          onError: (error, stackTrace) {},
        ),
      ),
    );
  }
}
