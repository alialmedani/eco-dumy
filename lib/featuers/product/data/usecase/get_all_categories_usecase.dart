import 'package:eco_dumy/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:eco_dumy/core/params/base_params.dart';
import 'package:eco_dumy/core/usecase/usecase.dart';
import 'package:eco_dumy/core/results/result.dart';
import 'package:eco_dumy/featuers/home/models/category_model.dart';
import 'package:eco_dumy/featuers/home/models/product_response_model.dart';
import 'package:eco_dumy/featuers/product/data/model/category_model.dart';
import 'package:eco_dumy/featuers/product/data/repository/product_repository.dart';
 

 
class GetAllCategoriesParams extends BaseParams {
  final GetListRequest? request;

  GetAllCategoriesParams({required this.request});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

 

class GetAllCategoriesUsecase
    extends UseCase<List<CategoryModel>, GetAllCategoriesParams> {
  late final ProductRepository repository;
  GetAllCategoriesUsecase(this.repository);

  @override
  Future<Result<List<CategoryModel>>> call({required GetAllCategoriesParams params}) {
    return repository.getAllCategories(params: params);
  }
}
