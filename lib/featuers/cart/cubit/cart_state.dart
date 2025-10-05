// lib/cart/cubit/cart_state.dart
part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<ProductCartItem> cartItems;
  final int totalItems;
  CartLoaded({required this.cartItems, required this.totalItems});
}

 
