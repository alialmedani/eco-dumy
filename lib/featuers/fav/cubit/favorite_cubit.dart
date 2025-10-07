// favorite_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:eco_dumy/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:eco_dumy/core/classes/cashe_helper.dart';
import 'package:eco_dumy/featuers/fav/cubit/favorite_state.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';
 class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  final List<ProductModel> _favorites = [];

  List<ProductModel> get items => List.unmodifiable(_favorites);

  // ----------------- Load Favorites -----------------
  void loadFavorites(List<ProductModel> initialList) async {
    emit(FavoriteLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      _favorites.clear();
      _favorites.addAll(initialList);
      emit(FavoriteLoaded(List.from(_favorites)));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

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

  // ----------------- Add product to favorites -----------------
  Future<void> addToFavorite(ProductModel product) async {
    try {
      if (!_favorites.any((p) => p.id == product.id)) {
        _favorites.add(product);
        emit(FavoriteLoaded(List.from(_favorites)));
      }
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  // ----------------- Check if product is favorite -----------------
  bool isFavorite(ProductModel product) {
    return _favorites.any((p) => p.id == product.id);
  }
}
