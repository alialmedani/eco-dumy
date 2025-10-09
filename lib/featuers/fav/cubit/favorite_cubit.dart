import 'package:bloc/bloc.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_state.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  final List<ProductModel> _favorites = [];

  List<ProductModel> get items => List.unmodifiable(_favorites);

  // ----------------- Toggle Favorite -----------------
  Future<void> toggle(ProductModel product) async {
    try {
      if (_favorites.any((p) => p.id == product.id)) {
        _favorites.removeWhere((p) => p.id == product.id);
      } else {
        _favorites.add(product);
      }
      emit(FavoriteLoaded(List.from(_favorites)));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  bool isFavorite(ProductModel product) {
    return _favorites.any((p) => p.id == product.id);
  }
}
