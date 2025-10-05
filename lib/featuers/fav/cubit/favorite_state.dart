import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
import 'package:meta/meta.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteLoaded extends FavoriteState {
  final List<ProductCartItem> cartItems;
  final int totalItems;
  FavoriteLoaded({required this.cartItems, required this.totalItems});
}

final class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}
