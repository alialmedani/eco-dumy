import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/featuers/product/cubit/product_cubit.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eco_dumy/featuers/product/screen/product_details_screen.dart';
import 'package:eco_dumy/featuers/product/screen/product_list_view_item.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ProductsByCategoryPage extends StatelessWidget {
  final String slug; // ex: beauty, home-decoration
  final String title; // ex: Beauty

  const ProductsByCategoryPage({
    super.key,
    required this.slug,
    required this.title,
  });

  String _pretty(String s) {
    if (s.isEmpty) return s;
    final withSpaces = s.replaceAll('-', ' ');
    return withSpaces[0].toUpperCase() + withSpaces.substring(1).toLowerCase();
  }

  String _titleText(BuildContext context) {
    final key = 'products_of';
    final tr = key.tr(namedArgs: {'category': _pretty(title)});
    return tr == key ? 'Products of ${_pretty(title)}' : tr;
  }

  // ---------------- UI helpers ----------------

  Widget _imageSkeletonRounded({double? radius}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            radius ?? AppPaddingSize.padding_16,
          ),
        ),
      ),
    );
  }

  Widget _netImage(
    String url, {
    double? radius,
    BoxFit fit = BoxFit.cover,
    Widget? error,
  }) {
    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (ctx, child, progress) {
        if (progress == null) return child;
        return _imageSkeletonRounded(
          radius: radius ?? AppPaddingSize.padding_12,
        );
      },
      errorBuilder: (ctx, err, st) => error ?? const _ImagePlaceholder(),
    );
  }

  Widget _gridItem(
    BuildContext context, {
    required ProductModel product,
    required int index,
  }) {
    final theme = Theme.of(context);

    String? img;
    if ((product.thumbnail ?? '').toString().isNotEmpty) {
      img = product.thumbnail!.toString();
    } else if ((product.images is List) &&
        (product.images?.isNotEmpty ?? false)) {
      img = product.images!.first?.toString();
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + index * 50),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: Transform.scale(scale: 0.95 + 0.05 * value, child: child),
          ),
        );
      },
      child: Material(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(AppPaddingSize.padding_16),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.08),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppPaddingSize.padding_16),
          onTap: () {
            // نفس صفحة التفاصيل تبعك
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DetailsPage(product: product)),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(AppPaddingSize.padding_12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // صورة
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppPaddingSize.padding_12,
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.5,
                    child: (img == null || img.isEmpty)
                        ? _imageSkeletonRounded(
                            radius: AppPaddingSize.padding_12,
                          )
                        : _netImage(
                            img,
                            radius: AppPaddingSize.padding_12,
                            fit: BoxFit.cover,
                            error: const _ImagePlaceholder(),
                          ),
                  ),
                ),
                const SizedBox(height: 8),
                // عنوان
                Text(
                  product.title?.toString() ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textDarka,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                // سعر + تقييم
                Row(
                  children: [
                    if (product.price != null)
                      Text(
                        '${product.price}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.graya,
                        ),
                      ),
                    if (product.price != null && product.rating != null)
                      const SizedBox(width: 10),
                    if (product.rating != null)
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            '${product.rating}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.graya,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildCarousel(List<ProductModel> list) {
    final items = list
        .where((p) => (p.images?.isNotEmpty ?? false))
        .take(5)
        .toList();
    if (items.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: CarouselSlider(
          options: CarouselOptions(
            height: 220,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            enableInfiniteScroll: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
          items: items.map((p) {
            final first = p.images.first.toString();
            return Builder(
              builder: (context) => InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  // لو بدك صفحة زوم
                  // Navigator.of(context).pushNamed(Routes.imageZoomPage, arguments: {'imageUrl': first});
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: _netImage(
                      first,
                      fit: BoxFit.cover,
                      error: const Icon(Icons.broken_image, size: 100),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.darkBluea,
      appBar: AppBar(
        backgroundColor: AppColors.darkBluea,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.white),
        title: Text(
          _titleText(context),
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // PaginationList نفسها، لكن منرجّع Slivers (كاروسيل + Grid)
      body: PaginationList<ProductModel>(
        withRefresh: true,
        physics: const BouncingScrollPhysics(),
        onCubitCreated: (cubit) {
          context.read<ProductCubit>().productCubit = cubit;
        },
        repositoryCallBack: (data) {
          if (data.skip == 0) data.take = 12;
          return context.read<ProductCubit>().fetchProductsByCategoryServices(
            request: data,
            category: slug,
          );
        },
        noDataWidget: Center(
          child: Text(
            () {
              final key = 'no_products_available';
              final tr = key.tr();
              return tr == key ? 'No products available' : tr;
            }(),
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.white,
            ),
          ),
        ),

        listBuilder: (list) {
          final products = List<ProductModel>.from(list);

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              if (products.isNotEmpty) _buildCarousel(products),

              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPaddingSize.padding_16,
                ),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppPaddingSize.padding_16,
                    crossAxisSpacing: AppPaddingSize.padding_16,
                    // نفس ارتفاع الكارت تبعك (أنت بالأصل عامل 320)
                    mainAxisExtent: 320,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = products[index];

                    // (اختياري) أنيميشن دخول بسيطة حوالين الكارت
                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: Duration(milliseconds: 300 + index * 40),
                      builder: (context, v, child) {
                        return Opacity(
                          opacity: v,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - v)),
                            child: child,
                          ),
                        );
                      },
                      // هون نستعمل نفس كارت الهوم
                      child: ProductListViewItem(
                        product: product,
                        itemIndex: index,
                      ),
                    );
                  }, childCount: products.length),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// --------- Placeholders ---------

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightGraya,
      child: const Center(
        child: Icon(
          Icons.image_not_supported,
          size: 24,
          color: AppColors.darkBluea,
        ),
      ),
    );
  }
}
