import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/results/result.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_cubit.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_state.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_card.dart';

// ------------------ Helper Pagination for local list ------------------
Future<Result<List<ProductModel>>> _paginateLocalFav({
  required List<ProductModel> full,
  required GetListRequest req,
}) async {
  final take = (req.take ?? 10).clamp(1, 100);
  final skip = (req.skip ?? 0).clamp(0, full.length);
  final end = (skip + take) > full.length ? full.length : (skip + take);
  final slice = full.sublist(skip, end);
  return Result<List<ProductModel>>(data: slice);
}

// ------------------ Favorites Screen ------------------
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading || state is FavoriteInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is FavoriteError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        final loaded = state as FavoriteLoaded;
        final list = loaded.items;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/svgs/logo_svg.svg'),
                const SizedBox(width: 8),
                Text("Favorites".tr()),
              ],
            ),
          ),
          body: list.isEmpty
              ? const _EmptyFavoritesPlaceholder()
              : PaginationList<ProductModel>(
key: ValueKey('fav-${loaded.items.length}'),
                  withRefresh: true,
                  physics: const BouncingScrollPhysics(),
                  onCubitCreated: (_) {},
                  repositoryCallBack: (req) =>
                      _paginateLocalFav(full: list, req: req),
                  noDataWidget: const SizedBox.shrink(),
                  listBuilder: (pageList) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: pageList.length,
                      itemBuilder: (context, index) {
                        final product = pageList[index];
                        return _FavoriteItem(product: product);
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}

// ------------------ Favorite Item Widget ------------------
class _FavoriteItem extends StatelessWidget {
  final ProductModel product;
  const _FavoriteItem({required this.product});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavoriteCubit>();

    return Dismissible(
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        final ok =
            await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text("remove_from_favorites".tr()),
                content: Text(
                  '${"are_you_sure_to_delete".tr()} "${product.title}"?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: Text("cancel".tr()),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    child: Text("confirm".tr()),
                  ),
                ],
              ),
            ) ??
            false;
        return ok;
      },
      onDismissed: (_) async {
        await cubit.toggle(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.title} ${"removed_from_favorites".tr()}'),
            backgroundColor: AppColors.kPrimaryColor2a,
            duration: const Duration(seconds: 2),
          ),
        );
      },
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: product.thumbnail ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(color: Colors.white),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.image_not_supported,
                  color: AppColors.darkBluea,
                ),
              ),
            ),
          ),
          title: Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.favorite, color: Colors.pinkAccent),
            onPressed: () async {
              await cubit.toggle(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${product.title} ${"removed_from_favorites".tr()}',
                  ),
                  backgroundColor: AppColors.kPrimaryColor2a,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ------------------ Empty Placeholder ------------------
class _EmptyFavoritesPlaceholder extends StatelessWidget {
  const _EmptyFavoritesPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svgs/empty_cart.svg',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 20),
          Text("No_favorites_yet".tr()),
        ],
      ),
    );
  }
}
