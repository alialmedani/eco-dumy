import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eco_dumy/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:eco_dumy/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:eco_dumy/core/results/result.dart';

import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:eco_dumy/featuers/product/data/repository/product_repository.dart';

import 'package:eco_dumy/featuers/product/data/usecase/get_all_product_usecase.dart';
import 'package:eco_dumy/featuers/product/data/usecase/get_all_categories_usecase.dart';
import 'package:eco_dumy/featuers/product/data/usecase/get_products_by_category_usecase.dart';
import 'dart:collection';

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
  // featuers/product/cubit/product_cubit.dart
  Future<Result> fetchProductsByCategoryServices({
    required GetListRequest request,
    required String category, // هذا هو الـ slug القادم من الشاشة
  }) async {
    final r = await GetProductsByCategoryUsecase(ProductRepository()).call(
      params: GetProductsByCategoryParams(
        request: request, // مرّر طلب الباجينيشن القادم من PaginationList
        category: category, // ← استعمل 'category' مش 'slug'
        // لو بدك ترجع فقط حقول محددة حتى في صفحة المنتجات، فعّل السطر التالي:
        // selectFields: const ['id','title','price','thumbnail','images'],
      ),
    );
    return r as Result; // upcast لواجهة PaginationList
  }

  // ----------------- 👇 جديد: معاينات صور التصنيفات (Bloc-way) -----------------
  // كاش الصور (موجود عندك)
  final Map<String, String?> _categoryThumbs = {};
  String? getCategoryThumb(String slug) => _categoryThumbs[slug];

  // طابور + تحكم بعدد الطلبات
  final Queue<String> _thumbQueue = Queue<String>();
  final Set<String> _inFlightThumbs = {};
  static const int _maxConcurrent = 2;

  void queueCategoryThumb(String slug, {bool priority = false}) {
    if (_categoryThumbs.containsKey(slug) || _inFlightThumbs.contains(slug)) {
      return; // عندي كاش أو قيد التحميل
    }
    // منع تكرار داخل الطابور:
    if (_thumbQueue.contains(slug)) return;

    if (priority) {
      _thumbQueue.addFirst(slug);
    } else {
      _thumbQueue.addLast(slug);
    }
    _pumpThumbQueue();
  }

  void _pumpThumbQueue() {
    while (_inFlightThumbs.length < _maxConcurrent && _thumbQueue.isNotEmpty) {
      final slug = _thumbQueue.removeFirst();
      _loadCategoryThumb(slug);
    }
  }
Future<void> _loadCategoryThumb(String slug) async {
    _inFlightThumbs.add(slug);
    try {
      final r = await GetProductsByCategoryUsecase(ProductRepository()).call(
        params: GetProductsByCategoryParams(
          request: GetListRequest(take: 1, skip: 0),
          category: slug,
          selectFields: const ['title', 'thumbnail', 'images'],
        ),
      );

      final dyn = (r as dynamic);
      final List<ProductModel> list =
          (dyn.data ?? dyn.value ?? const <ProductModel>[])
              as List<ProductModel>;

      String? url;
      if (list.isNotEmpty) {
        final p = list.first;
        final thumb = p.thumbnail?.toString() ?? '';
        if (thumb.isNotEmpty) {
          url = thumb;
        } else if (p.images.isNotEmpty) {
          final firstImg = p.images.first.toString();
          if (firstImg.isNotEmpty) url = firstImg;
        }
      }

      // ما نعمل emit إذا نفس القيمة:
      final old = _categoryThumbs[slug];
      _categoryThumbs[slug] = url;
      if (old != url) {
        emit(CategoryThumbsUpdated(Map<String, String?>.from(_categoryThumbs)));
      }
    } catch (_) {
      final old = _categoryThumbs[slug];
      _categoryThumbs[slug] = null;
      if (old != null) {
        emit(CategoryThumbsUpdated(Map<String, String?>.from(_categoryThumbs)));
      }
    } finally {
      _inFlightThumbs.remove(slug);
      _pumpThumbQueue();
    }
  }

}
