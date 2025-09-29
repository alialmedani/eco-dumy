import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:eco_dumy/core/utils/Navigation/navigation.dart';
import 'package:eco_dumy/featuers/home/screen/widget/rounded_container.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:eco_dumy/featuers/product/screen/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductListViewItem extends StatelessWidget {
  final ProductModel? product;
  final int itemIndex;

  const ProductListViewItem({
    super.key,
    required this.product,
    required this.itemIndex,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final isArabic = locale.languageCode == 'ar';
    if (product == null) return const SizedBox();
    // final dark = HelperFunctions.isDarkMode(context);
    return
     GestureDetector(
      onTap: () {
        // context.pushNamed(Routes.detailsPage, arguments: product);
        Navigation.push(DetailsPage(product: product!));
      },
      child: Container(
        width: 180,
        height: 300,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          // boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(AppPaddingSize.padding_8),
          // color: dark ? ColorsManager.darkerGrey : ColorsManager.white,
          color: AppColors.darkerGreya,
        ),
        child: Column(
          children: [
            RoundedContainar(
              height: 180,
              padding: const EdgeInsets.all(AppPaddingSize.padding_8),

              // backGroundColor: dark ? ColorsManager.dark : ColorsManager.light,
              backGroundColor: AppColors.darka,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppPaddingSize.padding_16,
                    ),
                    child: Image.network(
                      product!.thumbnail,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),

                  // Discount badge
                  Positioned(
                    right: isArabic ? 7 : null,
                    left: isArabic ? null : 7,
                    top: 7,
                    child: RoundedContainar(
                      radius: AppPaddingSize.padding_8,
                      backGroundColor: AppColors.secondarya.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPaddingSize.padding_8,
                        vertical: AppPaddingSize.padding_4,
                      ),
                      child: Text(
                        '${product!.discountPercentage.toStringAsFixed(0)}%',
                        style: Theme.of(context).textTheme.labelLarge!.apply(
                          color: AppColors.darkBluea,
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   left: isArabic ? 0 : null,
                  //   right: isArabic ? null : 0,
                  //   top: 0,
                  //   child: BlocBuilder<FavouriteCubit, FavouriteState>(
                  //     builder: (context, state) {
                  //       final isFavourite = state.favourites.any(
                  //         (p) => p.id == product!.id,
                  //       );
                  //       return Container(
                  //         width: TSizes.loadingIndicatorSize1,
                  //         height: TSizes.loadingIndicatorSize1,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(100),
                  //           color: dark
                  //               ? ColorsManager.black.withOpacity(0.9)
                  //               : ColorsManager.white.withOpacity(0.9),
                  //         ),
                  //         child: IconButton(
                  //           icon: Icon(
                  //             isFavourite
                  //                 ? Icons.favorite
                  //                 : Icons.favorite_border,
                  //             color: Colors.red,
                  //             size: TSizes.iconMd,
                  //           ),
                  //           onPressed: () {
                  //             final favCubit = context.read<FavouriteCubit>();
                  //             final isFavourite = favCubit.state.favourites.any(
                  //               (p) => p.id == product!.id,
                  //             );

                  //             favCubit.addOrRemoveFavourite(product!);

                  //             ScaffoldMessenger.of(context).showSnackBar(
                  //               SnackBar(
                  //                 backgroundColor: ColorsManager.kPrimaryColor2,
                  //                 duration: const Duration(milliseconds: 600),
                  //                 content: Text(
                  //                   isFavourite
                  //                       ? '${product?.title} ${S.current.removed_from_Favourite}'
                  //                       : '${product?.title} ${S.current.added_to_Favourite}',
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: AppPaddingSize.padding_16 / 2),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: AppPaddingSize.padding_8),
                child: Column(
                  crossAxisAlignment: isArabic
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      product?.title ?? 'No Title',
                      style: Theme.of(context).textTheme.labelLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: AppPaddingSize.padding_16),
                    Row(
                      // textDirection: TextDirection.ltr,
                      children: [
                        Text(
                          product?.brand ?? 'No Brand',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(color: AppColors.graya),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(width: AppPaddingSize.padding_4),
                        const Icon(
                          Icons.star,
                          size: AppPaddingSize.padding_16,
                          color: AppColors.mainBluea,
                        ),
                      ],
                    ),

                    /// هذا هو المفتاح 👇
                    const Spacer(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${product?.price ?? 0} \$',
                          style: Theme.of(context).textTheme.headlineSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.darkBluea,
                            borderRadius: BorderRadius.only(
                              topRight: isArabic
                                  ? Radius.zero
                                  : const Radius.circular(
                                      AppPaddingSize.padding_12,
                                    ),
                              bottomRight: isArabic
                                  ? Radius.zero
                                  : const Radius.circular(
                                      AppPaddingSize.padding_16,
                                    ),
                              topLeft: isArabic
                                  ? const Radius.circular(
                                      AppPaddingSize.padding_12,
                                    )
                                  : Radius.zero,
                              bottomLeft: isArabic
                                  ? const Radius.circular(
                                      AppPaddingSize.padding_16,
                                    )
                                  : Radius.zero,
                            ),
                          ),
                          child: SizedBox(
                            width: AppPaddingSize.padding_24 * 1.7,
                            height: AppPaddingSize.padding_24 * 1.4,
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  // context.read<OrderCubit>().addProduct(
                                  //   product!,
                                  // );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(
                                        milliseconds: 600,
                                      ),
                                      content: Text(
                                        '${product?.title} ${"added_to_order".tr()}',
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppPaddingSize.padding_8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
