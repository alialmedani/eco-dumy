 import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:eco_dumy/core/utils/Navigation/navigation.dart';
import 'package:eco_dumy/featuers/product/cubit/product_cubit.dart';
import 'package:eco_dumy/featuers/product/data/model/category_model.dart';
import 'package:eco_dumy/featuers/product/screen/category/products_by_category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesPaginationBar extends StatelessWidget {
  const CategoriesPaginationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 88, // صورة + نص
      child: PaginationList<CategoryModel>(
        withRefresh: true,
        physics: const BouncingScrollPhysics(),
        onCubitCreated: (cubit) {
          context.read<ProductCubit>().categoriesCubit = cubit;
        },
        repositoryCallBack: (data) {
          if (data.skip == 0) data.take = 20;
          return context.read<ProductCubit>().fetchAllCategoryServies(data);
        },
        noDataWidget: const SizedBox.shrink(),

        // 👇 هون تعريف list بشكل صحيح
        listBuilder: (items) {
          final list = List<CategoryModel>.from(items);
          if (list.isEmpty) return const SizedBox.shrink();

          return SizedBox(
            height: 80.h,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPaddingSize.padding_16,
                ),
                itemCount: list.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppPaddingSize.padding_16),
                itemBuilder: (context, index) {
                  final item = list[index];
                  final slug = item.slug;
                  final title = item.name;

                  final productCubit = context.read<ProductCubit>();
                  final thumb = productCubit.getCategoryThumb(slug);
                  if (thumb == null && index < 8) {
                    productCubit.queueCategoryThumb(slug, priority: true);
                  }

                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 240 + index * 40),
                    tween: Tween(begin: 0, end: 1),
                    builder: (context, value, child) => Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: 0.95 + 0.05 * value,
                        child: child,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigation.push(
                          ProductsByCategoryPage(slug: slug, title: title),
                        );
                      },
                      child: SizedBox(
                        width: 65,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: ClipOval(
                                child: BlocBuilder<ProductCubit, ProductState>(
                                  buildWhen: (p, c) =>
                                      c is CategoryThumbsUpdated,
                                  builder: (context, state) {
                                    final url = productCubit.getCategoryThumb(
                                      slug,
                                    );
                                    if (url == null || url.isEmpty) {
                                      return const _CatThumbPlaceholder();
                                    }
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.darkerGreya,

                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                      child: Image.network(
                                        url,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            const _CatThumbPlaceholder(),
                                        loadingBuilder: (ctx, child, prog) =>
                                            prog == null
                                            ? child
                                            : const _CatThumbSkeleton(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 70,
                              child: Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: AppColors.darkGreya,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// نفس البلايسهولدرات اللي كنت تستخدمها
class _CatThumbPlaceholder extends StatelessWidget {
  const _CatThumbPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppColors.lightGraya,
      child: Center(
        child: Icon(
          Icons.image_not_supported,
          size: 22,
          color: AppColors.darkBluea,
        ),
      ),
    );
  }
}

class _CatThumbSkeleton extends StatelessWidget {
  const _CatThumbSkeleton();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.lightGraya,
      child: const Center(
        child: SizedBox(
          width: 14,
          height: 14,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
