import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/utils/Navigation/navigation.dart';
import 'package:eco_dumy/featuers/cart/cubit/cart_cubit.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_cubit.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_state.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:eco_dumy/featuers/product/screen/widgets/buynow_button_widget.dart';
import 'package:eco_dumy/featuers/product/screen/widgets/image_zoom_page.dart';
import 'package:eco_dumy/featuers/product/screen/widgets/infoRow_widget.dart';
import 'package:eco_dumy/featuers/product/screen/widgets/product_description_widget.dart';
import 'package:eco_dumy/featuers/product/screen/widgets/product_title_price_widget.dart';
import 'package:eco_dumy/featuers/product/screen/widgets/product_image_widget.dart';
import 'package:eco_dumy/featuers/product/screen/widgets/w.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsPage extends StatelessWidget {
  final ProductModel product;

  const DetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      // backgroundColor: dark ? ColorsManager.dark : ColorsManager.light,
      backgroundColor: AppColors.darka,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Back + Favorite
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 22,
                      color: AppColors.lighta,
                    ),
                  ),
                  FavIconOnly(product: product, dark: true,),

                  // ❤️ زرّ المفضلة مع FavoriteCubit
                
                ],
              ),

              SizedBox(height: 15.h),

              /// Main Content
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: dark
                    //     ? ColorsManager.darkerGrey
                    //     : ColorsManager.light,
                    color: AppColors.darkerGreya,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16.w),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image + Hero Animation
                            GestureDetector(
                              onTap: () {
                                Navigation.push(
                                  ImageZoomPage(imageUrl: product.thumbnail),
                                );
                              },
                              child: Hero(
                                tag: 'product_image_${product.id}',
                                child: Container(
                                  // color: dark
                                  //     ? ColorsManager.darkerGrey
                                  //     : ColorsManager.light,
                                  color: AppColors.darkerGreya,

                                  child: ProductImageWidget(
                                    imageUrl: product.thumbnail,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20.h),

                            // Title & Price with animation
                            ProductTitlePriceWidget(
                              title: product.title,
                              price: product.price,
                            ),

                            SizedBox(height: 8.h),

                            // Description
                            ProductDescriptionSection(
                              description: product.description,
                            ),

                            SizedBox(height: 16.h),

                            // Info Rows
                            InfoRowWidget(
                              title: "Brand".tr(),
                              value: product.brand,
                            ),
                            InfoRowWidget(
                              title: "Availability".tr(),
                              value: translateAvailability(
                                product.availabilityStatus,
                              ),
                              valueColor:
                                  product.availabilityStatus.toLowerCase() ==
                                      "low stock".tr()
                                  ? Colors.red
                                  : Colors.green,
                            ),
                            InfoRowWidget(
                              title: "Warranty".tr(),
                              value: product.warrantyInformation,
                            ),
                            InfoRowWidget(
                              title: "Shipping".tr(),
                              value: product.shippingInformation,
                            ),
                            InfoRowWidget(
                              title: "Return_Policy".tr(),
                              value: product.returnPolicy,
                            ),
                            InfoRowWidget(
                              title: "min_Order".tr(),
                              value: '${product.minimumOrderQuantity}',
                            ),
                            InfoRowWidget(
                              title: "weight".tr(),
                              value: '${product.weight} g',
                            ),
                            InfoRowWidget(
                              title: "dimensions".tr(),
                              value:
                                  '${product.dimensions.width} x ${product.dimensions.height} x ${product.dimensions.depth} cm',
                            ),

                            SizedBox(height: 16.h),

                            // Rating
                            TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 600),
                              tween: Tween<double>(
                                begin: 0,
                                end: product.rating,
                              ),
                              builder: (context, value, child) {
                                return RatingRowWidget(
                                  rating: value,
                                  reviewCount: product.reviews.length,
                                );
                              },
                            ),

                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),

                      // Reviews
                      if (product.reviews.isNotEmpty)
                        SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final review = product.reviews[index];
                            return AnimatedOpacity(
                              duration: Duration(
                                milliseconds: 300 + index * 100,
                              ),
                              opacity: 1,
                              child: ReviewTileWidget(review: review),
                            );
                          }, childCount: product.reviews.length),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Buy Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: BuyNowButtonWidget(
          onPressed: () {
            // context.read<OrderCubit>().addProduct(product);
               final cartItem = ProductCartItem(product: product, quantity: 1);

            // استدعاء CartCubit لإضافة المنتج
            context.read<CartCubit>().addToCart(cartItem);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 600),
                content: Text('${product.title} ${"added_to_order".tr()}'),
              ),
            );
          },
          product: product,
        ),
      ),
    );
  }

  String translateAvailability(String value) {
    switch (value.toLowerCase()) {
      case 'low stock':
        return 'low stock'.tr();
      case 'in stock':
        return ".inStock".tr();
      default:
        return value;
    }
  }
}
