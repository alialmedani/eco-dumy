import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:eco_dumy/featuers/order/data/model/product_to_cart_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_cubit.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_state.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_card.dart';

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
        final list = loaded.favorites;

        return Scaffold(
          appBar: AppBar(centerTitle: true, title: Text("Favorites".tr())),
          body: list.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/favourite_item.svg',
                        width: AppPaddingSize.padding_40,
                        height: AppPaddingSize.padding_40,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "No_favorites_yet".tr(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: list.length,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemBuilder: (context, index) {
                    final product = list[index];
                    return Dismissible(
                      key: ValueKey(product.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) =>
                          context.read<FavoriteCubit>().toggle(product),
                      background: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.favorite, color: Colors.white),
                      ),
                      child: CartItemCard(
                        product: product.toCartItem(qty: 1),
                        showQuantityControls: false,
                        trailingIcon: Icons.favorite,
                        trailingColor: AppColors.kPrimaryColor2a,
                        onTrailingPressed: () =>
                            context.read<FavoriteCubit>().toggle(product),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
