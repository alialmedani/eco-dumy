// import 'package:easy_localization/easy_localization.dart';
// import 'package:eco_dumy/core/boilerplate/pagination/models/get_list_request.dart';
// import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
// import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
// import 'package:eco_dumy/core/results/result.dart';
// import 'package:eco_dumy/featuers/fav/cubit/favorite_cubit.dart';
// import 'package:eco_dumy/featuers/fav/cubit/favorite_state.dart';
// import 'package:eco_dumy/featuers/order/data/model/cart_item_card.dart';
// import 'package:eco_dumy/featuers/order/data/model/product_to_cart_ext.dart';
//  import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// // تقسيم محلي لقائمة المفضّلة (مثل السلة)
// Future<Result<List<ProductModel>>> _paginateLocalFav({
//   required List<ProductModel> full,
//   required GetListRequest req,
// }) async {
//   final take = (req.take ?? 10).clamp(1, 100);
//   final skip = (req.skip ?? 0).clamp(0, full.length);
//   final end = (skip + take) > full.length ? full.length : (skip + take);
//   final slice = full.sublist(skip, end);
//   return Result<List<ProductModel>>(data: slice);
// }

// class FavoritesScreen extends StatefulWidget {
//   const FavoritesScreen({super.key});

//   @override
//   State<FavoritesScreen> createState() => _FavoritesScreenState();
// }

// class _FavoritesScreenState extends State<FavoritesScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<FavoriteCubit>().load(); // أول ما تفتح الصفحة
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FavoriteCubit, FavoriteState>(
//       builder: (context, state) {
//         if (state is FavoriteLoading || state is FavoriteInitial) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//         if (state is FavoriteError) {
//           return Scaffold(body: Center(child: Text(state.message)));
//         }

//         final loaded = state as FavoriteLoaded;
//         final list = loaded.items;

//         return Scaffold(
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             centerTitle: true,
//             title: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SvgPicture.asset('assets/svgs/logo_svg.svg'),
//                 const SizedBox(width: 8),
//                 Text("Favorites".tr()),
//               ],
//             ),
//           ),

//           body: list.isEmpty
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         'assets/svgs/empty_cart.svg',
//                         width: 200,
//                         height: 200,
//                       ),
//                       const SizedBox(height: 20),
//                       Text("No_favorites_yet".tr()),
//                     ],
//                   ),
//                 )
//               : PaginationList<ProductModel>(
//                   // زي السلة: أربط المفتاح بالعدد ليصير rebuild
//                   key: ValueKey('fav-${loaded.total}'),
//                   withRefresh: true,
//                   physics: const BouncingScrollPhysics(),
//                   onCubitCreated: (_) {},
//                   repositoryCallBack: (req) {
//                     if (req.skip == 0) req.take = 10;
//                     return _paginateLocalFav(full: list, req: req);
//                   },
//                   noDataWidget: const SizedBox.shrink(),

//                   listBuilder: (pageList) {
//                     return ListView.builder(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       itemCount: pageList.length,
//                       itemBuilder: (context, index) {
//                         final product = pageList[index];

//                         // استخدم الكارت الموّحد بتحويل بسيط:
//                         final cartItem = product.toCartItem(qty: 1);

//                         return Dismissible(
//                           key: ValueKey(product.id),
//                           direction: DismissDirection.endToStart,
//                           confirmDismiss: (_) async {
//                             final ok =
//                                 await showDialog<bool>(
//                                   context: context,
//                                   builder: (ctx) => AlertDialog(
//                                     title: Text("remove_from_favorites".tr()),
//                                     content: Text(
//                                       '${"are_you_sure_to_delete".tr()} "${product.title}"?',
//                                     ),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () =>
//                                             Navigator.pop(ctx, false),
//                                         child: Text("cancel".tr()),
//                                       ),
//                                       TextButton(
//                                         onPressed: () =>
//                                             Navigator.pop(ctx, true),
//                                         child: Text("confirm".tr()),
//                                       ),
//                                     ],
//                                   ),
//                                 ) ??
//                                 false;
//                             return ok;
//                           },
//                           onDismissed: (_) async {
//                             await context.read<FavoriteCubit>().toggle(product);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(
//                                   '${product.title} ${"removed_from_favorites".tr()}',
//                                 ),
//                                 backgroundColor: AppColors.kPrimaryColor2a,
//                                 duration: const Duration(seconds: 2),
//                               ),
//                             );
//                           },
//                           background: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             alignment: Alignment.centerRight,
//                             color: Colors.red,
//                             child: const Icon(
//                               Icons.delete,
//                               color: Colors.white,
//                             ),
//                           ),

//                           child: CartItemCard(
//                             product: cartItem,
//                             // المفضّلة: بدون أزرار كمية
//                             showQuantityControls: false,

//                             // زر جانبي = قلب (إزالة من المفضلة)
//                             trailingIcon: Icons.favorite,
//                             trailingColor: Colors.pinkAccent,
//                             onTrailingPressed: () async {
//                               await context.read<FavoriteCubit>().toggle(
//                                 product,
//                               );
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     '${product.title} ${"removed_from_favorites".tr()}',
//                                   ),
//                                   backgroundColor: AppColors.kPrimaryColor2a,
//                                   duration: const Duration(seconds: 2),
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//         );
//       },
//     );
//   }
// }
