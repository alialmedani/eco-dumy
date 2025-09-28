// // category_products_screen.dart
// import 'package:eco_dumy/core/boilerplate/pagination/models/get_list_request.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
// import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
// import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
// import 'package:eco_dumy/core/constant/text_styles/font_size.dart';
// import 'package:eco_dumy/featuers/product/cubit/product_cubit.dart';
// import 'package:eco_dumy/featuers/product/data/model/product_model.dart';

// class CategoryProductsScreen extends StatelessWidget {
//   final String slug;
//   final String title;
//   const CategoryProductsScreen({
//     super.key,
//     required this.slug,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.xbackgroundColor3,
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: AppColors.white,
//         foregroundColor: AppColors.black,
//         elevation: 0.4,
//         centerTitle: false,
//       ),
//       body: PaginationList<ProductModel>(
//         withRefresh: true,
//         physics: const BouncingScrollPhysics(),
//         noDataWidget: Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: AppPaddingSize.padding_80,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Icon(
//                 Icons.category_outlined,
//                 size: AppFontSize.size_42,
//                 color: AppColors.grey89,
//               ),
//               SizedBox(height: AppFontSize.size_12),
//               Text(
//                 'No items in this category',
//                 style: TextStyle(
//                   color: AppColors.black,
//                   fontSize: AppFontSize.size_16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         onCubitCreated: (cubit) {
//           context.read<ProductCubit>().productCubit = cubit; // نفس الهيكل تبعك
//         },
//         repositoryCallBack: (data) {
//           // ⚠️ مهم: نمرّر الـ slug ليجيب منتجات الكاتيجوري
//           // إذا عندك تعديل بسيط بالبارامز، استخدم GetAllDrinkParams مع categorySlug (شوف البند 4)
//           return context.read<ProductCubit>().fetchAllProductServies(
//             GetListRequest(
//               skip: data.skip,
//               take: data.take,
//               params: {'category': slug},
//             ),
//           );
//         },
//         listBuilder: (apiList) {
//           return CustomScrollView(
//             physics: const BouncingScrollPhysics(),
//             slivers: [
//               SliverPadding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: AppPaddingSize.padding_22,
//                 ),
//                 sliver: SliverGrid(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisExtent: AppFontSize.size_270,
//                     crossAxisSpacing: AppFontSize.size_15,
//                     mainAxisSpacing: AppFontSize.size_20,
//                   ),
//                   delegate: SliverChildBuilderDelegate(
//                     (context, i) =>
//                         _GridProductCard(model: apiList[i], index: i),
//                     childCount: apiList.length,
//                   ),
//                 ),
//               ),
//               const SliverToBoxAdapter(
//                 child: SizedBox(height: AppFontSize.size_40),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// class _GridProductCard extends StatelessWidget {
//   final ProductModel model;
//   final int index;
//   const _GridProductCard({required this.model, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     final img = (model.thumbnail?.isNotEmpty == true)
//         ? model.thumbnail!
//         : ((model.images?.isNotEmpty == true) ? model.images!.first : '');
//     return Material(
//       color: Colors.transparent,
//       child: Ink(
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.circular(AppFontSize.size_18),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.black.withValues(alpha: 0.04),
//               blurRadius: 20,
//               offset: const Offset(0, 12),
//             ),
//           ],
//         ),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(AppFontSize.size_18),
//           onTap: () {},
//           child: Padding(
//             padding: const EdgeInsets.all(AppPaddingSize.padding_14),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(AppFontSize.size_16),
//                     child: Image.network(
//                       img,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) => Container(
//                         color: AppColors.whiteF3,
//                         child: const Icon(
//                           Icons.image_not_supported_outlined,
//                           color: AppColors.greyA4,
//                           size: AppFontSize.size_32,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: AppFontSize.size_10),
//                 Text(
//                   model.title ?? '',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: AppFontSize.size_16,
//                     color: AppColors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   model.description,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     color: AppColors.grey89,
//                     fontSize: AppFontSize.size_12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
