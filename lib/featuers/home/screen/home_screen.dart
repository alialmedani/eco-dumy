import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:eco_dumy/core/constant/text_styles/font_size.dart';
import 'package:eco_dumy/featuers/auth/data/model/login_model.dart';
import 'package:eco_dumy/featuers/home/cubit/home_cubit.dart';
import 'package:eco_dumy/featuers/home/cubit/home_state.dart';
import 'package:eco_dumy/featuers/home/screen/widget/promo_slider.dart';
import 'package:eco_dumy/featuers/product/screen/category/categories_pagination_bar.dart';
import 'package:eco_dumy/featuers/product/screen/product_grid.dart';
import 'package:eco_dumy/featuers/home/screen/widget/home_app_bar.dart';
import 'package:eco_dumy/featuers/home/screen/widget/primary_header_container.dart';
import 'package:eco_dumy/featuers/home/screen/widget/section_heading.dart';
import 'package:eco_dumy/featuers/product/cubit/product_cubit.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darka,
      body: PaginationList<ProductModel>(
        withRefresh: true,
        physics: const BouncingScrollPhysics(),
        noDataWidget: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppPaddingSize.padding_80,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_cafe_outlined,
                size: AppFontSize.size_42,
                color: AppColors.xsecondaryColor.withValues(alpha: 0.7),
              ),
              const SizedBox(height: AppFontSize.size_12),
              Text(
                'home_no_coffee'.tr(),
                style: TextStyle(
                  color: AppColors.xsecondaryColor,
                  fontSize: AppFontSize.size_16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        onCubitCreated: (cubit) {
          context.read<ProductCubit>().productCubit = cubit;
        },
        repositoryCallBack: (data) {
          if (data.skip == 0) {
            data.take = 4;
          }

          return context.read<ProductCubit>().fetchAllProductServies(data);
        },
        listBuilder: (apiList) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryHeaderContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeAppBar(),
                      const SizedBox(height: AppPaddingSize.padding_32),

                      // شريط البحث
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPaddingSize.padding_24,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Search_in_Store".tr(),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppPaddingSize.padding_32),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPaddingSize.padding_24,
                        ),
                        child: Column(
                          children: [
                            SectionHeading(
                              title: "Popular_Categories".tr(),
                              textColor: AppColors.darkGreya,
                              showActionButton: true,
                              onPressed: () {},
                            ),
                            const SizedBox(height: AppPaddingSize.padding_16),
                             const CategoriesPaginationBar(),

                            const SizedBox(height: AppPaddingSize.padding_16),
                            SectionHeading(
                              title: "New_Releases".tr(),
                              textColor: AppColors.darkGreya,
                              showActionButton: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPaddingSize.padding_24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const PromoSlider(),
                      const SizedBox(height: AppPaddingSize.padding_16),
                      SectionHeading(
                        title: "Best_Selling_Product".tr(),
                        showActionButton: false,
                        titleStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGreya,
                        ),
                      ),

                      // 👇 حُط ProductGrid هون — بعد العنوان مباشرة
                      const SizedBox(height: AppPaddingSize.padding_16),
                      ProductGrid(
                        products: apiList,
                      ), // apiList جاي من PaginationList وهو List<ProductModel>

                      const SizedBox(height: AppPaddingSize.padding_24),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
