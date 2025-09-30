import 'package:eco_dumy/core/constant/end_points/api_url.dart';
import 'package:eco_dumy/core/data_source/remote_data_source.dart';
import 'package:eco_dumy/core/http/http_method.dart';
import 'package:eco_dumy/core/repository/core_repository.dart';
import 'package:eco_dumy/core/results/result.dart';
import 'package:eco_dumy/featuers/product/data/model/category_model.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
  import 'package:eco_dumy/featuers/product/data/usecase/get_all_categories_usecase.dart';
import 'package:eco_dumy/featuers/product/data/usecase/get_products_by_category_usecase.dart';

import '../usecase/get_all_product_usecase.dart';

class ProductRepository extends CoreRepository {
  Future<Result<List<ProductModel>>> requestAllProdcut({
    required GetAllProductParams params,
  }) async {
    final result = await RemoteDataSource.request<List<ProductModel>>(
      withAuthentication: false,
      url: getAllProduct,
      method: HttpMethod.GET,
      queryParameters: params.toJson(),
      converter: (json) {
        final list = (json['products'] as List?) ?? const [];

        return list
            .map<ProductModel>(
              (e) => ProductModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      },
    );
    return call(result: result);
  }

  Future<Result<List<CategoryModel>>> getAllCategories({
    required GetAllCategoriesParams params,
  }) async {
    final result = await RemoteDataSource.request<List<CategoryModel>>(
      withAuthentication: false,
      url: getCategoriesUrl,
      method: HttpMethod.GET,
      queryParameters: params.toJson(),
      converter2: (json) {
        final list = (json as List?) ?? const [];
        return list
            .map<CategoryModel>(
              (e) => CategoryModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      },
    );
    return call(result: result);
  }

  // داخل ProductRepository
// featuers/product/data/repository/product_repository.dart
  Future<Result<List<ProductModel>>> getProductsByCategory({
    required GetProductsByCategoryParams params,
  }) async {
    final result = await RemoteDataSource.request<List<ProductModel>>(
      withAuthentication: false,
      // مهم: المسار فيه الـ slug
      url: '$getProductsBaseUrl/category/${params.slug}',
      method: HttpMethod.GET,
      queryParameters: params.toJson(), // ⬅️ هون رح ينزل select فعليًا
      converter: (json) {
        final list = (json['products'] as List?) ?? const [];
        return list
            .map<ProductModel>(
              (e) => ProductModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      },
    );
    return call(result: result);
  }



  
}
