// lib/featuers/order/widgets/cart_item_card.dart
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemCard extends StatelessWidget {
  final ProductCartItem product;

  // للسلة
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  // زر الإجراء الجانبي (حذف من السلة / إزالة من المفضلة)
  final IconData trailingIcon;
  final Color trailingColor;
  final VoidCallback onTrailingPressed;

  // تحكم مرئي
  final bool showQuantityControls;

  const CartItemCard({
    super.key,
    required this.product,
    required this.onTrailingPressed,
    this.onIncrease,
    this.onDecrease,
    this.trailingIcon = Icons.delete_outline, // بالسلة delete
    this.trailingColor = Colors.redAccent,
    this.showQuantityControls = true, // بالمفضلة نخليه false
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkerGreya,

      elevation: 7,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),

            child: Image.network(
              product.product.thumbnail,
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),

            // Container(
            //   color: const Color(0xFF151922),
            //   width: 80,
            //   height: 80,
            //   child: product.thumbnail.isEmpty
            //       ? const Center(
            //           child: Icon(
            //             Icons.image_not_supported,
            //             color: Colors.white54,
            //             size: 20,
            //           ),
            //         )
            //       : Image.network(
            //           product.thumbnail,
            //           fit: BoxFit.cover,
            //           errorBuilder: (_, __, ___) => const Center(
            //             child: Icon(
            //               Icons.image_not_supported,
            //               color: Colors.white54,
            //               size: 20,
            //             ),
            //           ),
            //           loadingBuilder: (ctx, child, prog) => prog == null
            //               ? child
            //               : const Center(
            //                   child: SizedBox(
            //                     width: 16,
            //                     height: 16,
            //                     child: CircularProgressIndicator(strokeWidth: 2),
            //                   ),
            //                 ),
            //         ),
            // ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppPaddingSize.padding_12),
                Text(
                  product.product.title,
                  style: TextStyle(color: AppColors.lighta),
                  // style: TextStyles(context).font18DarkBlueSemiBold(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppPaddingSize.padding_6),
                Row(
                  children: [
                    // Text(
                    //   product.brand ?? '',
                    //   style: TextStyles(
                    //     context,
                    //   ).font17kTextColorSemiBold(context),
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    const SizedBox(width: AppPaddingSize.padding_4),
                    const Icon(
                      Icons.star,
                      size: AppPaddingSize.padding_16,
                      color: AppColors.mainBluea,
                    ),
                  ],
                ),
                const SizedBox(height: AppPaddingSize.padding_6),
                Text(
                  '${product.product.price} \$ × ${product.quantity}',
                  style: TextStyle(color: AppColors.lighta),
                  // style: TextStyles(context).font15DarkBlueMedium(context),
                ),
                const SizedBox(height: AppPaddingSize.padding_6),
                Row(
                  children: [
                    IconButton(
                      onPressed: onDecrease,
                      icon: const Icon(Icons.remove, color: AppColors.lighta),
                    ),
                    Text(
                      '${product.quantity}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.lighta,
                      ),
                    ),
                    IconButton(
                      onPressed: onIncrease,
                      icon: const Icon(Icons.add, color: AppColors.lighta),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed:  onTrailingPressed,
            icon: const Icon(
              Icons.remove_shopping_cart_outlined,
              color: AppColors.kPrimaryColor2a,
            ),
          ),
        ],
      ),
    );
  }
}
