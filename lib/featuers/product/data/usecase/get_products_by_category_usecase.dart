import 'package:eco_dumy/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:eco_dumy/core/params/base_params.dart';
import 'package:eco_dumy/core/usecase/usecase.dart';
import 'package:eco_dumy/core/results/result.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:eco_dumy/featuers/product/data/repository/product_repository.dart';

class GetProductsByCategoryParams extends BaseParams {
  final GetListRequest? request;

  /// كان اسمها سابقًا `category`. سنبقي الاسم كما هو،
  /// ونضيف Getter اسمه `slug` ليتوافق مع أي استدعاءات موجودة.
  final String category;

  GetProductsByCategoryParams({required this.request, required this.category});

  /// توافق خلفي: أي كود يستدعي params.slug سيعمل الآن
  String get slug => category;

  /// DummyJSON يستخدم limit/skip
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (request != null) {
      if (request!.take != null) data['limit'] = request!.take;
      if (request!.skip != null) data['skip'] = request!.skip;
    }
    return data;
  }
}

class GetProductsByCategoryUsecase
    extends UseCase<List<ProductModel>, GetProductsByCategoryParams> {
  final ProductRepository repository;
  GetProductsByCategoryUsecase(this.repository);

  @override
  Future<Result<List<ProductModel>>> call({
    required GetProductsByCategoryParams params,
  }) {
    return repository.getProductsByCategory(params: params);
  }
}
