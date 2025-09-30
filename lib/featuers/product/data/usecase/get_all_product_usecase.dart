import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
 
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/product_repository.dart';

class GetAllProductParams extends BaseParams {
  final GetListRequest? request;

  GetAllProductParams({required this.request});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
     return data;
  }
}

class GetAllProdcutUsecase extends UseCase<List<ProductModel>, GetAllProductParams> {
  late final ProductRepository repository;
  GetAllProdcutUsecase(this.repository);

  @override
  Future<Result<List<ProductModel>>> call({required GetAllProductParams params}) {
    return repository.requestAllProdcut(params: params);
  }
}
