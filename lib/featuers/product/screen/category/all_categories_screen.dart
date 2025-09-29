import 'package:easy_localization/easy_localization.dart';
import 'package:eco_dumy/featuers/product/screen/category/products_by_category_page.dart'; // صفحة المنتجات حسب التصنيف (أعد التسمية لو لزم)
import 'package:eco_dumy/featuers/product/cubit/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eco_dumy/core/boilerplate/pagination/widgets/pagination_list.dart';
import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/core/constant/app_padding/app_padding.dart';
import 'package:eco_dumy/featuers/product/data/model/category_model.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:eco_dumy/core/boilerplate/pagination/models/get_list_request.dart';

// ↓↓↓ سنستخدم الريبو + اليوزكيس الموجودين عندك
import 'package:eco_dumy/featuers/product/data/repository/product_repository.dart';
import 'package:eco_dumy/featuers/product/data/usecase/get_products_by_category_usecase.dart';

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
          'all_categories'.tr(),
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
            'no_categories_available'.tr(),
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
              mainAxisExtent: 180,
            ),
            itemBuilder: (context, index) {
              final item = list[index];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProductsByCategoryPage(
                        slug: item.slug, // نمرّر الـ slug الصحيح
                        title: item.name, // للعرض فقط
                      ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ← صورة من أول منتج داخل هذا التصنيف
                      _CategoryPreviewImage(slug: item.slug),

                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPaddingSize.padding_8,
                        ),
                        child: Text(
                          item.name,
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

/// ويدجت تجيب أول منتج (limit=1) وتعرض صورته كمصغّرة للتصنيف
class _CategoryPreviewImage extends StatefulWidget {
  final String slug;
  const _CategoryPreviewImage({required this.slug});

  @override
  State<_CategoryPreviewImage> createState() => _CategoryPreviewImageState();
}

class _CategoryPreviewImageState extends State<_CategoryPreviewImage> {
  Future<String?>? _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchFirstProductImage(widget.slug);
  }

  Future<String?> _fetchFirstProductImage(String slug) async {
    // نادينا الـ UseCase عبر الريبو مباشرة (لا نعدّل core)
    final repo = ProductRepository();
    final params = GetProductsByCategoryParams(
      request: GetListRequest(take: 1, skip: 0),
      category: slug,
    );

    final result = await repo.getProductsByCategory(params: params);

    // ملاحظة: افترضت أن Result لديك فيه when(success/failure).
    // إن كانت واجهتك مختلفة (fold / isSuccess / data)، عدّل السطور الثلاثة التالية وفق Coreك.
    String? imageUrl;
    // try/catch لحماية من أي اختلاف بصيغة Result
    try {
      // إذا عندك .when
      // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
      // ^ فقط لو Result عندكم محدد @visibleForTesting، تجاهل التحذير
      // بديل: افحص أنواعه يدويًا إذا لزم.
      // هنا نفترض:
      // result.when(success: (data) { ... }, failure: (err) { ... });

      // نحاول الوصول لقائمة المنتجات
      dynamic data;
      // طرق فكّ Result شائعة: (عدّل حسب Coreك)
      // 1) when
      // data = await result.when(success: (d) => d, failure: (_) => <ProductModel>[]);
      // 2) maybeWhen
      // data = result.maybeWhen(success: (d) => d, orElse: () => <ProductModel>[]);
      // 3) خصائص مباشرة:
      if ((result as dynamic).data != null) {
        data = (result as dynamic).data;
      } else if ((result as dynamic).value != null) {
        data = (result as dynamic).value;
      }

      final List<ProductModel> list =
          (data as List?)?.cast<ProductModel>() ?? const [];

      if (list.isNotEmpty) {
        final p = list.first;
        if ((p.thumbnail).toString().isNotEmpty) {
          imageUrl = p.thumbnail.toString();
        } else if ((p.images is List) && (p.images.isNotEmpty)) {
          imageUrl = p.images!.first?.toString();
        }
      }
    } catch (_) {
      // تجاهل: سنُظهر Placeholder
    }

    return imageUrl; // قد تكون null => نعرض Placeholder
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const _CatImageSkeleton();
        }
        final url = snap.data;
        if (url == null || url.isEmpty) {
          return const _CatImagePlaceholder();
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(AppPaddingSize.padding_16),
          child: AspectRatio(
            aspectRatio: 1, // مربع
            child: Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const _CatImagePlaceholder(),
              loadingBuilder: (ctx, child, progress) {
                if (progress == null) return child;
                return const _CatImageSkeleton();
              },
            ),
          ),
        );
      },
    );
  }
}

class _CatImagePlaceholder extends StatelessWidget {
  const _CatImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: AppColors.lightGraya,
        borderRadius: BorderRadius.circular(AppPaddingSize.padding_16),
      ),
      child: const Icon(
        Icons.image_not_supported,
        color: AppColors.darkBluea,
        size: 28,
      ),
    );
  }
}

class _CatImageSkeleton extends StatelessWidget {
  const _CatImageSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
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
