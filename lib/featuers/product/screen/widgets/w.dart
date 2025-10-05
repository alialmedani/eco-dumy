// fav_icon_only.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_cubit.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_state.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';

/// أيقونة مفضّلة تُعيد البناء لوحدها فقط.
/// - كبسة: toggle في الـCubit.
/// - تعتمد BlocSelector لتحديث الأيقونة فقط.
class FavIconOnly extends StatelessWidget {
  final ProductModel product;
  final bool dark;
  final double iconSize;

  const FavIconOnly({
    super.key,
    required this.product,
    this.dark = false,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteCubit, FavoriteState, bool>(
      selector: (state) {
        if (state is FavoriteLoaded) {
          // return state.contains(product.id);
        }
        return false;
      },
      builder: (context, isFav) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: dark
                ? Colors.black.withOpacity(0.9)
                : Colors.white.withOpacity(0.9),
          ),
          child: IconButton(
            onPressed: () {},
            // onPressed: () => context.read<FavoriteCubit>().toggle(product),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                key: ValueKey<bool>(isFav),
                color: Colors.red,
                size: iconSize,
              ),
            ),
            tooltip: isFav ? 'Remove from favorites' : 'Add to favorites',
          ),
        );
      },
    );
  }
}
