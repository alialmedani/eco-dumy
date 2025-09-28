import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
 import 'package:eco_dumy/featuers/home/new/cubit/home_cubit.dart';
import 'package:eco_dumy/featuers/home/new/cubit/home_state.dart';
import 'package:eco_dumy/featuers/home/new/screen/tad/widget/home_app_bar.dart';
import 'package:eco_dumy/featuers/home/new/screen/tad/widget/primary_header_container.dart';
import 'package:eco_dumy/featuers/home/new/screen/tad/widget/section_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenA extends StatelessWidget {
  HomeScreenA({super.key});
  final ScrollController _scrollController = ScrollController();
   @override
  Widget build(BuildContext context) {
    //   final homeCubit = context.read<HomeCubit>();
    //   final dark = HelperFunctions.isDarkMode(context);

    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     if (_scrollController.hasClients) {
    //       _scrollController.jumpTo(homeCubit.state.scrollPosition);
    //     }
    //   });

    //   _scrollController.addListener(() {
    //     homeCubit.updateScrollPosition(_scrollController.position.pixels);

    //     if (_scrollController.position.pixels >=
    //         _scrollController.position.maxScrollExtent - 100) {
    //       homeCubit.loadMoreProducts();
    //     }
    //   });

    return Scaffold(
      // backgroundColor: dark ? AppColors.darka : AppColors.lighta,
      backgroundColor: AppColors.darka,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          // final dark = HelperFunctions.isDarkMode(context);

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

                      // زر البحث — GestureDetector لفتح شاشة البحث
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPaddingSize.padding_24,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // من صفحة HomeScreen لما تروح SearchScreen
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) => MultiBlocProvider(
                                  //       providers: [
                                  //         BlocProvider.value(
                                  //           value: context.read<HomeCubit>(),
                                  //         ),
                                  //         BlocProvider.value(
                                  //           value: context
                                  //               .read<FavouriteCubit>(),
                                  //         ),
                                  //         BlocProvider.value(
                                  //           value: context.read<OrderCubit>(),
                                  //         ),
                                  //       ],
                                  //       child: const SearchScreen(),
                                  //     ),
                                  //   ),
                                  // );
                                },
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
                              textColor:
                                  //  HelperFunctions.isDarkMode(context)
                                  //     ? ColorsManager.darkGrey
                                  //     : ColorsManager.white,,
                                  AppColors.darkGreya,
                              showActionButton: true,
                              onPressed: () {
                                // context.read<NavigationCubit>().onIconTap(3);
                              },
                            ),
                            const SizedBox(height: AppPaddingSize.padding_16),
                            // const CategoriesBlocBuilder(),
                            const SizedBox(height: AppPaddingSize.padding_16),
                            SectionHeading(
                              title: "New_Releases".tr(),
                              textColor:
                                  //  HelperFunctions.isDarkMode(context)
                                  //     ? ColorsManager.darkGrey
                                  //     : ColorsManager.white,
                                  AppColors.darkGreya,
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
                    children: [
                      // const PromoSlider(),
                      const SizedBox(height: AppPaddingSize.padding_16),
                      SectionHeading(
                        title: "Best_Selling_Product".tr(),
                        showActionButton: false,
                        titleStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color:
                              //  dark
                              //     ? ColorsManager.darkGrey
                              //     : ColorsManager.mainBlue,
                              AppColors.darkGreya,
                        ),
                      ),
                    ],
                  ),
                ),

                // هنا عرض البحث أو المنتجات العادية حسب الحالة
                // if (state.query.isNotEmpty) ...[
                //   const SizedBox(height: TSizes.spaceBtwItems),
                //   if (state.isSearching)
                //     const Center(child: CircularProgressIndicator())
                //   else if (state.searchResults.isEmpty)
                //     Center(
                //       child: Text(
                //         S.current.No_results_found,
                //         style: const TextStyle(
                //           fontSize: 18,
                //           color: Colors.grey,
                //         ),
                //       ),
                //     )
                //   else
                //     Padding(
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: TSizes.defaultSpace,
                //       ),
                //       child: GridView.builder(
                //         physics: const NeverScrollableScrollPhysics(),
                //         shrinkWrap: true,
                //         gridDelegate:
                //             const SliverGridDelegateWithFixedCrossAxisCount(
                //               crossAxisCount: 2,
                //               mainAxisSpacing: TSizes.gridViewSpacing,
                //               crossAxisSpacing: TSizes.gridViewSpacing,
                //               mainAxisExtent: 300,
                //             ),
                //         itemCount: state.searchResults.length,
                //         itemBuilder: (context, index) {
                //           final product = state.searchResults[index];
                //           return ProductListViewItem(
                //             product: product!,
                //             itemIndex: index,
                //           );
                //         },
                //       ),
                //     ),
                // ] else
                //   const Padding(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: TSizes.defaultSpace,
                //     ),
                //     child: ProductsBlocBuilder(),
                //   ),

                // if (state.isLoadingMore) ...[
                //   const SizedBox(height: 16),
                //   Center(
                //     child: CircularProgressIndicator(
                //       color: Theme.of(context).brightness == Brightness.dark
                //           ? ColorsManager.white
                //           : ColorsManager.mainBlue,
                //     ),
                //   ),
                //   const SizedBox(height: 16),
                // ],
              ],
            ),
          );
        },
      ),
    );
  }
}
