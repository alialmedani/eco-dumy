// import 'package:ad_fluuter/core/helbers/helber_function.dart';
// import 'package:ad_fluuter/core/helbers/sizes.dart';
// import 'package:ad_fluuter/core/routing/routrs.dart';
// import 'package:ad_fluuter/core/theming/clolors.dart';
// import 'package:ad_fluuter/featuers/details/ui/details_page.dart';
// import 'package:ad_fluuter/featuers/home/logic/home_cubit.dart';
// import 'package:ad_fluuter/featuers/home/logic/home_state.dart';
// import 'package:ad_fluuter/featuers/home/ui/new/product/product_list_view_item.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:eco_dumy/featuers/product/screen/product_list_view_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shimmer/shimmer.dart';

// class CategoryProductsPage extends StatelessWidget {
//   final String categoryName;
//   final String categorySlug;
//   final String? imageUrl;

//   const CategoryProductsPage({
//     super.key,
//     required this.categoryName,
//     required this.categorySlug,
//     this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<HomeCubit>();
//     final dark = HelperFunctions.isDarkMode(context);
//     final theme = Theme.of(context);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (cubit.state.query != categorySlug || cubit.state.products.isEmpty) {
//         cubit.fetchProductsByCategory(categorySlug);
//       }
//     });

//     Widget buildLoadingShimmer(bool darkMode) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
//         child: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 500),
//           child: GridView.builder(
//             itemCount: 6,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: TSizes.gridViewSpacing,
//               crossAxisSpacing: TSizes.gridViewSpacing,
//               mainAxisExtent: 300,
//             ),
//             itemBuilder: (_, __) {
//               return Shimmer.fromColors(
//                 baseColor: darkMode ? Colors.grey[800]! : Colors.grey[300]!,
//                 highlightColor: darkMode
//                     ? Colors.grey[700]!
//                     : Colors.grey[100]!,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: darkMode ? Colors.grey[850] : Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 150,
//                         color: darkMode ? Colors.grey[700] : Colors.grey[400],
//                       ),
//                       const SizedBox(height: 8),
//                       Container(
//                         height: 20,
//                         width: 100,
//                         color: darkMode ? Colors.grey[700] : Colors.grey[400],
//                       ),
//                       const SizedBox(height: 4),
//                       Container(
//                         height: 20,
//                         width: 60,
//                         color: darkMode ? Colors.grey[700] : Colors.grey[400],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       );
//     }

//     Widget buildCarousel(List products, BuildContext context) {
//       return SliverToBoxAdapter(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           child: CarouselSlider(
//             options: CarouselOptions(
//               height: 220,
//               autoPlay: true,
//               enlargeCenterPage: true,
//               viewportFraction: 0.9,
//               enableInfiniteScroll: true,
//               autoPlayInterval: const Duration(seconds: 4),
//               autoPlayAnimationDuration: const Duration(milliseconds: 800),
//               autoPlayCurve: Curves.fastOutSlowIn,
//             ),
//             items: products
//                 .where(
//                   (product) =>
//                       product?.images != null && product!.images!.isNotEmpty,
//                 )
//                 .take(5)
//                 .map((product) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return InkWell(
//                         borderRadius: BorderRadius.circular(14),
//                         onTap: () {
//                           Navigator.of(context).pushNamed(
//                             Routes.imageZoomPage,
//                             arguments: {'imageUrl': product.images!.first},
//                           );
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 4),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(14),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.15),
//                                 blurRadius: 8,
//                                 offset: const Offset(0, 4),
//                               ),
//                             ],
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(22),
//                             child: CachedNetworkImage(
//                               imageUrl: product.images!.first,
//                               placeholder: (context, url) => Shimmer.fromColors(
//                                 baseColor: dark
//                                     ? Colors.grey[800]!
//                                     : Colors.grey[300]!,
//                                 highlightColor: dark
//                                     ? Colors.grey[700]!
//                                     : Colors.grey[100]!,
//                                 child: Container(
//                                   color: dark ? Colors.grey[850] : Colors.white,
//                                 ),
//                               ),
//                               errorWidget: (context, url, error) =>
//                                   const Icon(Icons.broken_image, size: 100),
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 })
//                 .toList(),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: dark ? ColorsManager.dark : ColorsManager.light,
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 1,
//         iconTheme: IconThemeData(color: dark ? Colors.white : Colors.black87),
//         title: Text(
//           categoryName,
//           style: theme.textTheme.titleLarge?.copyWith(
//             color: dark ? Colors.white : Colors.black87,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           if (state.isLoadingSpecializations) {
//             return buildLoadingShimmer(dark);
//           }

//           if (state.products.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.category_outlined,
//                     size: 60,
//                     color: dark ? Colors.white54 : Colors.black38,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'لا توجد منتجات حالياً في هذه الفئة',
//                     style: theme.textTheme.titleMedium?.copyWith(
//                       color: dark ? Colors.white70 : Colors.black54,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   ElevatedButton(
//                     onPressed: () =>
//                         cubit.fetchProductsByCategory(categorySlug),
//                     child: const Text('إعادة المحاولة'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return RefreshIndicator(
//             onRefresh: () async => cubit.fetchProductsByCategory(categorySlug),
//             child: CustomScrollView(
//               slivers: [
//                 if (state.products.isNotEmpty)
//                   buildCarousel(state.products, context),
//                 SliverPadding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: TSizes.defaultSpace,
//                   ),
//                   sliver: SliverGrid(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           mainAxisSpacing: TSizes.gridViewSpacing,
//                           crossAxisSpacing: TSizes.gridViewSpacing,
//                           mainAxisExtent: 300,
//                         ),
//                     delegate: SliverChildBuilderDelegate((context, index) {
//                       final product = state.products[index];

//                       return TweenAnimationBuilder<double>(
//                         tween: Tween(begin: 0, end: 1),
//                         duration: Duration(milliseconds: 300 + index * 50),
//                         builder: (context, value, child) {
//                           return Opacity(
//                             opacity: value,
//                             child: Transform.translate(
//                               offset: Offset(0, 30 * (1 - value)),
//                               child: Transform.scale(
//                                 scale: 0.95 + 0.05 * value,
//                                 child: child,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Material(
//                           color: dark ? Colors.grey[900] : Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           elevation: 3,
//                           shadowColor: Colors.black.withOpacity(0.1),
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(12),
//                             onTap: () {
//                               Navigator.of(context).push(
//                                 PageRouteBuilder(
//                                   transitionDuration: const Duration(
//                                     milliseconds: 500,
//                                   ),
//                                   pageBuilder: (context, animation, _) =>
//                                       FadeTransition(
//                                         opacity: animation,
//                                         child: DetailsPage(product: product),
//                                       ),
//                                   transitionsBuilder:
//                                       (context, animation, _, child) {
//                                         final offsetTween =
//                                             Tween<Offset>(
//                                               begin: const Offset(0, 0.1),
//                                               end: Offset.zero,
//                                             ).chain(
//                                               CurveTween(curve: Curves.easeOut),
//                                             );

//                                         return SlideTransition(
//                                           position: animation.drive(
//                                             offsetTween,
//                                           ),
//                                           child: FadeTransition(
//                                             opacity: animation,
//                                             child: child,
//                                           ),
//                                         );
//                                       },
//                                 ),
//                               );
//                             },
//                             child: ProductListViewItem(
//                               product: product!,
//                               itemIndex: index,
//                             ),
//                           ),
//                         ),
//                       );
//                     }, childCount: state.products.length),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
