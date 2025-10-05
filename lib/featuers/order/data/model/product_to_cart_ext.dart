import 'package:eco_dumy/featuers/order/data/model/cart_item_model.dart';
import 'package:eco_dumy/featuers/product/data/model/product_model.dart';

extension ProductToCart on ProductModel {
  ProductCartItem toCartItem({int qty = 1}) =>
      ProductCartItem(product: this, quantity: qty);
}
