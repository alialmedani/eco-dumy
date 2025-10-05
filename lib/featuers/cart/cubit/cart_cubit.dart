import 'package:bloc/bloc.dart';
import 'package:eco_dumy/core/classes/cashe_helper.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void loadCart() {
    try {
      emit(CartLoading());
      final cartItems = CacheHelper.getCartItems();
      final totalItems = CacheHelper.cartItemCount;
      emit(CartLoaded(cartItems: cartItems, totalItems: totalItems));
    } catch (e) {
      emit(CartError('Failed to load cart: ${e.toString()}'));
    }
  }

  Future<void> addToCart(ProductCartItem item) async {
    try {
      await CacheHelper.addToCart(item);
      loadCart();
    } catch (e) {
      emit(CartError('Failed to add item to cart: ${e.toString()}'));
    }
  }

  // ✅ النسخ الجديدة بعد تعديل الـ model:
 Future<void> removeProduct(ProductCartItem item) async {
    await CacheHelper.removeFromCart(item);
    loadCart();
  }

  Future<void> increaseQuantity(ProductCartItem item) async {
    await CacheHelper.updateCartItemQuantity(item, item.quantity + 1);
    loadCart();
  }

  Future<void> decreaseQuantity(ProductCartItem item) async {
    await CacheHelper.updateCartItemQuantity(item, item.quantity - 1);
    loadCart();
  }


   

 Future<void> updateQuantity(ProductCartItem item, int newQuantity) async {
    try {
      await CacheHelper.updateCartItemQuantity(item, newQuantity);
      loadCart();
    } catch (e) {
      emit(CartError('Failed to update item quantity: ${e.toString()}'));
    }
  }

  Future<void> removeFromCart(ProductCartItem item) async {
    try {
      await CacheHelper.removeFromCart(item);
      loadCart();
    } catch (e) {
      emit(CartError('Failed to remove item from cart: ${e.toString()}'));
    }
  }


  Future<void> clearCart() async {
    try {
      await CacheHelper.clearCart();
      loadCart();
    } catch (e) {
      emit(CartError('Failed to clear cart: ${e.toString()}'));
    }
  }
}
