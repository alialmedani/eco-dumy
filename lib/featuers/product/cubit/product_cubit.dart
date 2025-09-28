import 'package:bloc/bloc.dart';
import 'package:eco_dumy/featuers/product/data/usecase/get_all_categories_usecase.dart';
import 'package:meta/meta.dart';
import '../../../core/boilerplate/pagination/cubits/pagination_cubit.dart';
import '../../../core/results/result.dart';
import '../data/repository/product_repository.dart';
import '../data/usecase/get_all_product_usecase.dart';
part 'product_state.dart';
 
class ProductCubit extends Cubit<ProductState> {
  PaginationCubit? productCubit;

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
}
