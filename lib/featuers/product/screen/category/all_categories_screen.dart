import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/featuers/product/cubit/product_cubit.dart';
import 'package:eco_dumy/featuers/product/screen/category/products_by_category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:eco_dumy/featuers/product/data/model/category_model.dart';

/// ثوابت الشبكة (لازم تطابق GridView)
const _kCrossAxisCount = 2;
const _kMainAxisExtent = 180.0; // نفس mainAxisExtent
const _kRowSpacing = AppPaddingSize.padding_16; // نفس mainAxisSpacing
const _kPrefetchRows = 2; // كم صفّ نحمّل مسبقًا بعد الظاهر

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

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
          () {
            final k = 'all_categories';
            final t = k.tr();
            return t == k ? 'All categories' : t;
          }(),
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: PaginationList<CategoryModel>(
        withRefresh: true,
        physics: const BouncingScrollPhysics(),
        onCubitCreated: (cubit) {
          context.read<ProductCubit>().categoriesCubit = cubit;
        },
        repositoryCallBack: (data) {
          if (data.skip == 0) data.take = 12;
          return context.read<ProductCubit>().fetchAllCategoryServies(data);
        },
        noDataWidget: Center(
          child: Text(
            () {
              final k = 'no_categories_available';
              final t = k.tr();
              return t == k ? 'No categories available' : t;
            }(),
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
        listBuilder: (list) {
          return _GridWithPrefetch(list: list);
        },
      ),
    );
  }
}

class _GridWithPrefetch extends StatelessWidget {
  final List<CategoryModel> list;
  const _GridWithPrefetch({required this.list});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notif) {
        if (notif is ScrollUpdateNotification) {
          final metrics = notif.metrics;
          final pixels = metrics.pixels;

          final rowHeight = _kMainAxisExtent + _kRowSpacing;
          final firstVisibleRow = (pixels / rowHeight).floor().clamp(
            0,
            1 << 30,
          );
          final firstVisibleIndex = (firstVisibleRow * _kCrossAxisCount).clamp(
            0,
            list.length - 1,
          );
          final lastPrefetchRow = firstVisibleRow + _kPrefetchRows;
          final lastPrefetchIndex =
              (((lastPrefetchRow + 1) * _kCrossAxisCount) - 1).clamp(
                0,
                list.length - 1,
              );

          final cubit = context.read<ProductCubit>();
          for (int i = firstVisibleIndex; i <= lastPrefetchIndex; i++) {
            final slug = list[i].slug;
            if (slug.isEmpty) continue;
            final cached = cubit.getCategoryThumb(slug);
            if (cached == null || cached.isEmpty) {
              cubit.queueCategoryThumb(slug);
            }
          }
        }
        return false;
      },
      child: GridView.builder(
        padding: const EdgeInsets.all(AppPaddingSize.padding_16),
        itemCount: list.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _kCrossAxisCount,
          mainAxisSpacing: _kRowSpacing,
          crossAxisSpacing: AppPaddingSize.padding_16,
          mainAxisExtent: _kMainAxisExtent,
        ),
        itemBuilder: (context, index) {
          final item = list[index];
          final slug = item.slug;
          final title = item.name;

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      ProductsByCategoryPage(slug: slug, title: title),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.darka,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 110,
                    width: double.infinity,
                    child: BlocBuilder<ProductCubit, ProductState>(
                      buildWhen: (prev, curr) => curr is CategoryThumbsUpdated,
                      builder: (context, state) {
                        final cubit = context.read<ProductCubit>();
                        final img = cubit.getCategoryThumb(slug);

                        final isAboveTheFold = index < 10;
                        if ((img == null || img.isEmpty) &&
                            slug.isNotEmpty &&
                            isAboveTheFold) {
                          cubit.queueCategoryThumb(slug, priority: true);
                        }

                        if (img == null || img.isEmpty) {
                          return const _CatImagePlaceholder();
                        }

                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightGraya,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                         
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: img,
                              fit: BoxFit.fitHeight,
                              placeholder: (context, url) => Container(
                                color: Colors.white, // خلفية أبيض أثناء التحميل
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.lightGraya,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color:
                                    Colors.white, // خلفية أبيض عند فشل التحميل
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: AppColors.darkBluea,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.graya,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---- Placeholder ----
class _CatImagePlaceholder extends StatelessWidget {
  const _CatImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
    decoration: BoxDecoration(
        color: AppColors.lightGraya,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.darkBluea,
        ),
      ),
    );
  }
}
