// import 'package:ad_fluuter/core/networking/api_error_handler.dart';
// import 'package:ad_fluuter/core/networking/api_result.dart';
// import 'package:ad_fluuter/featuers/home/data/Apis/home_api_service.dart';
// import 'package:ad_fluuter/featuers/home/data/models/product_response_model.dart';

// class HomeRepo {
//   final HomeApiService _homeApiService;

//   HomeRepo(HomeApiService homeApiService) : _homeApiService = homeApiService;
//   Future<ApiResult<ProductResponse>> getProdcut({
//     required int limit,
//     required int skip,
//   }) async {
//     try {
//       final response =
//           await _homeApiService.getProdcut(limit: limit, skip: skip);
//       return ApiResult.success(response);
//     } catch (error) {
//       return ApiResult.failure(ErrorHandler.handle(error));
//     }
//   }

//   Future<ApiResult<Product?>> getFirstProductByCategory(String category) async {
//     try {
//       final response = await _homeApiService.getProductsByCategory(category);
//       final product = response.products?.isNotEmpty == true
//           ? response.products!.first
//           : null;
//       return ApiResult.success(product);
//     } catch (error) {
//       return ApiResult.failure(ErrorHandler.handle(error));
//     }
//   }

//   Future<ApiResult<List<Product?>>> searchProducts(String query) async {
//     try {
//       final response = await _homeApiService.searchProducts(query);

//       // فلترة المنتجات اللي عنوانها يحتوي query (بحساسية صغيرة case-insensitive)
//       final filteredProducts = (response.products ?? []).where((product) {
//         return product?.title?.toLowerCase().contains(query.toLowerCase()) ??
//             false;
//       }).toList();

//       return ApiResult.success(filteredProducts);
//     } catch (error) {
//       return ApiResult.failure(ErrorHandler.handle(error));
//     }
//   }


//    Future<ApiResult<ProductResponse>> getProductsByCategory(String categorySlug) async {
//     try {
//       final response = await _homeApiService.getProductsByCategory(categorySlug);
//       return ApiResult.success(response);
//     } catch (error) {
//       return ApiResult.failure(ErrorHandler.handle(error));
//     }
//   }
// }
 
