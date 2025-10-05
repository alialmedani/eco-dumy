import 'package:bloc/bloc.dart';
import 'package:eco_dumy/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:eco_dumy/core/classes/cashe_helper.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  PaginationCubit? cartCubit;

  void loadCart() {
    emit(CartLoading());
    final cartItems = CacheHelper.getCartItems();
    final totalItems = CacheHelper.cartItemCount;
    emit(CartLoaded(cartItems: cartItems, totalItems: totalItems));
  }

  // ✅ إضافة المنتج للكارت
  Future<void> addToCart(ProductCartItem item) async {
    await CacheHelper.addToCart(item);
    loadCart();
    // تحديث الـ pagination
    cartCubit?.getList(loadMore: false);
  }

  Future<void> removeProduct(ProductCartItem item) async {
    await CacheHelper.removeFromCart(item);
    loadCart();
    cartCubit?.getList(loadMore: false);
  }

  Future<void> increaseQuantity(ProductCartItem item) async {
    await CacheHelper.updateCartItemQuantity(item, item.quantity + 1);
    loadCart();
    cartCubit?.getList(loadMore: false);
  }

  Future<void> decreaseQuantity(ProductCartItem item) async {
    await CacheHelper.updateCartItemQuantity(item, item.quantity - 1);
    loadCart();
    cartCubit?.getList(loadMore: false);
  }

  Future<void> updateQuantity(ProductCartItem item, int newQuantity) async {
    await CacheHelper.updateCartItemQuantity(item, newQuantity);
    loadCart();
    cartCubit?.getList(loadMore: false);
  }

  Future<void> clearCart() async {
    await CacheHelper.clearCart();
    loadCart();
    cartCubit?.getList(loadMore: false);
  }
}
