// featuers/product/data/usecase/get_products_by_category_usecase.dart
import 'package:eco_dumy/core/boilerplate/pagination/models/get_list_request.dart';
import 'package:eco_dumy/core/params/base_params.dart';
import 'package:eco_dumy/core/usecase/usecase.dart';
import 'package:eco_dumy/core/results/result.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
import 'package:eco_dumy/featuers/product/data/repository/product_repository.dart';

class GetProductsByCategoryParams extends BaseParams {
  final GetListRequest? request;
  final String category; // slug
  final List<String>? selectFields; // ⬅️ جديد

  GetProductsByCategoryParams({
    required this.request,
    required this.category,
    this.selectFields,
  });

  String get slug => category;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    // دمج limit/skip من الـ request لو موجودة
    final r = request;
    if (r != null) {
      if (r.take != null) data['limit'] = r.take;
      if (r.skip != null) data['skip'] = r.skip;
    }

    // أهم سطر: حطّ select=title,thumbnail,images
    if (selectFields != null && selectFields!.isNotEmpty) {
      data['select'] = selectFields!.join(',');
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
