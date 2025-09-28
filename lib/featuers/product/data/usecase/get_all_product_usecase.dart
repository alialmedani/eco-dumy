import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
 
import '../../../../core/boilerplate/pagination/models/get_list_request.dart';
import '../../../../core/params/base_params.dart';
import '../../../../core/results/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/product_repository.dart';

class GetAllDrinkParams extends BaseParams {
  final GetListRequest? request;

  GetAllDrinkParams({required this.request});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
     return data;
  }
}

class GetAllDrinkUsecase extends UseCase<List<ProductModel>, GetAllDrinkParams> {
  late final ProductRepository repository;
  GetAllDrinkUsecase(this.repository);

  @override
  Future<Result<List<ProductModel>>> call({required GetAllDrinkParams params}) {
    return repository.requestAllDrink(params: params);
  }
}
