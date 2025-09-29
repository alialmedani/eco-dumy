import 'package:bloc/bloc.dart';
import 'package:eco_dumy/featuers/product/data/usecase/get_all_categories_usecase.dart';
import 'package:meta/meta.dart';
import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/results/result.dart';
import '../data/repository/product_repository.dart';
import '../data/usecase/get_all_product_usecase.dart';
import '../data/usecase/get_products_by_category_usecase.dart';
import '../../../core/boilerplate/pagination/models/get_list_request.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  PaginationCubit? productCubit;
  PaginationCubit? categoriesCubit; // ✅ كيوبت الكاتيغوري

  ProductCubit() : super(ProductInitial());

  Future<Result> fetchAllProductServies(data) async {
    return await GetAllDrinkUsecase(
      ProductRepository(),
    ).call(params: GetAllDrinkParams(request: data));
  }

  Future<Result> fetchAllCategoryServies(data) async {
    return await GetAllCategoriesUsecase(
      ProductRepository(),
    ).call(params: GetAllCategoriesParams(request: data));
  }

  // ↓↓↓ جديد: منتجات حسب التصنيف
  Future<Result> fetchProductsByCategoryServices({
    required GetListRequest request,
    required String category,
  }) async {
    return await GetProductsByCategoryUsecase(ProductRepository()).call(
      params: GetProductsByCategoryParams(request: request, category: category),
    );
  }
}
