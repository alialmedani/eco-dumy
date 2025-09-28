// import 'package:ad_fluuter/core/networking/api_constants.dart';
// import 'package:ad_fluuter/featuers/home/data/Apis/home_api_constants.dart';
// import 'package:ad_fluuter/featuers/home/data/models/product_response_model.dart';
// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';

// part 'home_api_service.g.dart';

// @RestApi(baseUrl: ApiConstants.apiBaseUrl)
// abstract class HomeApiService {
//   factory HomeApiService(Dio dio) = _HomeApiService;

//   @GET(HomeApiConstants.prodcutEP)
//   Future<ProductResponse> getProdcut({
//     @Query('limit') required int limit,
//     @Query('skip') required int skip,
//   });

//   @GET('products/category/{category}')
//   Future<ProductResponse> getProductsByCategory(
//     @Path("category") String category,
//   );
//   @GET(HomeApiConstants.searchProductsEP)
//   Future<ProductResponse> searchProducts(@Query('q') String query);

// @GET("products/category/{category}")
//   Future<ProductResponse> getProductsByCategory3(
//     @Path("category") String categorySlug,
//   );
// }
