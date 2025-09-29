import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/featuers/product/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
class ProductsByCategoryPage extends StatelessWidget {
  final String slug; // يُستخدم في الـ API (مثل: beauty, home-decoration)
  final String title; // للعرض فقط (مثل: Beauty, Home Decoration)

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

  // محاولة ترجمة مع fallback إن كانت المفاتيح ناقصة
  String _titleText(BuildContext context) {
    final key = 'products_of';
    final tr = key.tr(namedArgs: {'category': _pretty(title)});
    // إذا رجع نفس المفتاح (دلالة أنه غير موجود)، استخدم نص بسيط
    if (tr == key) return 'Products of ${_pretty(title)}';
    return tr;
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
      body: PaginationList<ProductModel>(
        withRefresh: true,
        physics: const BouncingScrollPhysics(),
        onCubitCreated: (cubit) {
          context.read<ProductCubit>().productCubit = cubit;
        },
        repositoryCallBack: (data) {
          // DummyJSON يدعم limit/skip مع مسار category أيضًا
          if (data.skip == 0) data.take = 12;
          return context.read<ProductCubit>().fetchProductsByCategoryServices(
            request: data,
            category: slug,
          );
        },
        noDataWidget: Center(
          child: Text(
            // fallback لو المفتاح ناقص
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
          // كل عنصر: صورة + عنوان + سعر (اختياري) بتصميم بسيط ونظيف
          return ListView.separated(
            padding: const EdgeInsets.all(AppPaddingSize.padding_16),
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = list[index];

              // جِب أفضل رابط للصورة: thumbnail ثم أول صورة
              String? imageUrl;
              if ((item.thumbnail ?? '').toString().isNotEmpty) {
                imageUrl = item.thumbnail!.toString();
              } else if ((item.images is List) &&
                  (item.images?.isNotEmpty ?? false)) {
                // بعض الـ APIs ترجع List<dynamic>، لذلك نحاول cast إلى String
                final first = item.images!.first;
                imageUrl = first?.toString();
              }

              return Container(
                padding: const EdgeInsets.all(AppPaddingSize.padding_12),
                decoration: BoxDecoration(
                  color: AppColors.darka,
                  borderRadius: BorderRadius.circular(
                    AppPaddingSize.padding_16,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // صورة المنتج (80x80) بزاويا دائرية
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppPaddingSize.padding_12,
                      ),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: imageUrl == null || imageUrl.isEmpty
                            ? _ImagePlaceholder()
                            : Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                // Placeholder أثناء التحميل
                                loadingBuilder: (ctx, child, progress) {
                                  if (progress == null) return child;
                                  return const _ImageSkeleton();
                                },
                                // صورة fallback عند الخطأ
                                errorBuilder: (ctx, error, stack) =>
                                    const _ImagePlaceholder(),
                              ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // تفاصيل
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // العنوان
                          Text(
                            item.title?.toString() ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          // سطر ثانٍ: السعر والتقييم (اختياريان)
                          Row(
                            children: [
                              if (item.price != null)
                                Text(
                                  // تنسيق بسيط للسعر
                                  '${item.price}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: AppColors.graya,
                                  ),
                                ),
                              if (item.price != null && item.rating != null)
                                const SizedBox(width: 10),
                              if (item.rating != null)
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${item.rating}',
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(color: AppColors.graya),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // أيقونة بسيطة للدخول إلى التفاصيل لاحقًا
                    const Icon(
                      Icons.chevron_right,
                      color: AppColors.graya,
                      size: 22,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

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

class _ImageSkeleton extends StatelessWidget {
  const _ImageSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightGraya.withOpacity(0.6),
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
