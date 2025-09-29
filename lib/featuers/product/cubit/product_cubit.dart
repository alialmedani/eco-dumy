import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eco_dumy/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:eco_dumy/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:eco_dumy/core/results/result.dart';

import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:eco_dumy/featuers/product/data/model/category_model.dart';
import 'package:eco_dumy/featuers/product/data/repository/product_repository.dart';

import 'package:eco_dumy/featuers/product/data/usecase/get_all_product_usecase.dart';
import 'package:eco_dumy/featuers/product/data/usecase/get_all_categories_usecase.dart';
import 'package:eco_dumy/featuers/product/data/usecase/get_products_by_category_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  PaginationCubit? productCubit;
  PaginationCubit? categoriesCubit;

  ProductCubit() : super(ProductInitial());

  /// يُستدعى من PaginationList للمنتجات العامة
  Future<Result> fetchAllProductServies(GetListRequest data) async {
    final r = await GetAllDrinkUsecase(
      ProductRepository(),
    ).call(params: GetAllDrinkParams(request: data));
    return r as Result; // upcast للـ RepositoryCallBack في core
  }

  /// يُستدعى من PaginationList للتصنيفات
  Future<Result> fetchAllCategoryServies(GetListRequest data) async {
    final r = await GetAllCategoriesUsecase(
      ProductRepository(),
    ).call(params: GetAllCategoriesParams(request: data));
    return r as Result; // upcast
  }

  /// يُستدعى من PaginationList لمنتجات تصنيف معيّن (slug)
  Future<Result> fetchProductsByCategoryServices({
    required GetListRequest request,
    required String category, // هذا هو الـ slug
  }) async {
    final r = await GetProductsByCategoryUsecase(ProductRepository()).call(
      params: GetProductsByCategoryParams(
        request: request,
        category: category,
        // إن كنت أضفت selectFields في Params:
        // selectFields: const ['thumbnail','images','title','price','rating'],
      ),
    );
    return r as Result; // upcast
  }

  // ----------------- 👇 جديد: معاينات صور التصنيفات (Bloc-way) -----------------

  final Map<String, String?> _categoryThumbs = {}; // slug -> image
  final Set<String> _inFlightThumbs = {}; // لمنع التكرار

  /// Getter للواجهة (تقرأه الـ UI)
  String? getCategoryThumb(String slug) => _categoryThumbs[slug];

  /// حمّل صورة معاينة لأول منتج في التصنيف، مرّة واحدة فقط
  Future<void> ensureCategoryThumbLoaded(String slug) async {
    if (_categoryThumbs.containsKey(slug) || _inFlightThumbs.contains(slug)) {
      return;
    }
    _inFlightThumbs.add(slug);
    try {
      final r = await GetProductsByCategoryUsecase(ProductRepository()).call(
        params: GetProductsByCategoryParams(
          request: GetListRequest(take: 1, skip: 0),
          category: slug,
          // selectFields: const ['thumbnail','images'],
        ),
      );

      // فضّ الـ Result بحسب Coreك (raw)
      List<ProductModel> list;
      final dyn = (r as dynamic);
      if (dyn.data != null) {
        list = (dyn.data as List).cast<ProductModel>();
      } else if (dyn.value != null) {
        list = (dyn.value as List).cast<ProductModel>();
      } else {
        list = const [];
      }

      String? url;
      if (list.isNotEmpty) {
        final p = list.first;
        if ((p.thumbnail).toString().isNotEmpty) {
          url = p.thumbnail.toString();
        } else if ((p.images is List) && (p.images.isNotEmpty)) {
          url = p.images.first.toString();
        }
      }

      _categoryThumbs[slug] = url; // قد تكون null → Placeholder
      emit(CategoryThumbsUpdated(Map<String, String?>.from(_categoryThumbs)));
    } catch (_) {
      _categoryThumbs[slug] = null;
      emit(CategoryThumbsUpdated(Map<String, String?>.from(_categoryThumbs)));
    } finally {
      _inFlightThumbs.remove(slug);
    }
  }



  
}
