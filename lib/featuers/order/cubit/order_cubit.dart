import 'package:bloc/bloc.dart';
import 'package:eco_dumy/core/boilerplate/pagination/cubits/pagination_cubit.dart';
import 'package:eco_dumy/core/classes/cashe_helper.dart';
import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  PaginationCubit? orderCubit;
  OrderCubit() : super(OrderInitial());

  int _version = 0;

  List<ProductCartItem> get cart => CacheHelper.getProductCartItems();

  double get totalPrice =>
      cart.fold<double>(0.0, (sum, e) => sum + (e.price * e.quantity));

  Future<void> addProduct(ProductCartItem item) async {
    await CacheHelper.addProductToCart(item);
    emit(OrderChanged(++_version));
  }

  Future<void> removeProduct(ProductCartItem item) async {
    await CacheHelper.removeProductFromCart(item.id);
    emit(OrderChanged(++_version));
  }

  Future<void> increaseQuantity(ProductCartItem item) async {
    await CacheHelper.updateProductQuantity(item.id, item.quantity + 1);
    emit(OrderChanged(++_version));
  }

  Future<void> decreaseQuantity(ProductCartItem item) async {
    final newQty = item.quantity - 1;
    await CacheHelper.updateProductQuantity(item.id, newQty);
    emit(OrderChanged(++_version));
  }

  Future<void> clearCart() async {
    await CacheHelper.clearProductCart();
    emit(OrderChanged(++_version));
  }
}
