import 'package:easy_localization/easy_localization.dart';
  import 'package:eco_dumy/featuers/product/cubit/product_cubit.dart';
import 'package:eco_dumy/featuers/product/screen/category/products_by_category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:eco_dumy/featuers/product/data/model/category_model.dart';

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
          // لو المفتاح ناقص، استعمل نص بديل بسيط
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
          return GridView.builder(
            padding: const EdgeInsets.all(AppPaddingSize.padding_16),
            itemCount: list.length,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppPaddingSize.padding_16,
              crossAxisSpacing: AppPaddingSize.padding_16,
              mainAxisExtent: 180, // ← مناسب بعد تقييد الصورة
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
                    borderRadius: BorderRadius.circular(
                      AppPaddingSize.padding_16,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // ✅ صورة معاينة عبر Bloc (بدون FutureBuilder)
                      SizedBox(
                        height: 110,
                        width: double.infinity,
                        child: BlocBuilder<ProductCubit, ProductState>(
                          buildWhen: (prev, curr) =>
                              curr is CategoryThumbsUpdated,
                          builder: (context, state) {
                            final cubit = context.read<ProductCubit>();
                            final img = cubit.getCategoryThumb(slug);

                            // اطلب التحميل مرّة واحدة إذا غير موجودة
                            if (img == null &&
                                !(state is CategoryThumbsUpdated &&
                                    state.thumbs.containsKey(slug))) {
                              cubit.ensureCategoryThumbLoaded(slug);
                            }

                            if (img == null) {
                              return const _CatImagePlaceholder();
                            }
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(
                                AppPaddingSize.padding_16,
                              ),
                              child: Image.network(
                                img,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const _CatImagePlaceholder(),
                                loadingBuilder: (ctx, child, prog) =>
                                    prog == null
                                    ? child
                                    : const _CatImageSkeleton(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPaddingSize.padding_8,
                        ),
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
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
          );
        },
      ),
    );
  }
}

// ---- Widgets بسيطة للـ Placeholder / Skeleton ----

class _CatImagePlaceholder extends StatelessWidget {
  const _CatImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGraya,
        borderRadius: BorderRadius.circular(AppPaddingSize.padding_16),
      ),
      child: const Center(
        child: Icon(
          Icons.image_not_supported,
          color: AppColors.darkBluea,
          size: 28,
        ),
      ),
    );
  }
}

class _CatImageSkeleton extends StatelessWidget {
  const _CatImageSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGraya.withOpacity(0.6),
        borderRadius: BorderRadius.circular(AppPaddingSize.padding_16),
      ),
      child: const Center(
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
