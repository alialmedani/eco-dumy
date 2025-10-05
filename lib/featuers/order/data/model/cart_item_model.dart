import 'package:eco_dumy/featuers/product/data/model/product_model.dart';

class ProductCartItem {
  final ProductModel product;
  final int quantity;

  const ProductCartItem({required this.product, this.quantity = 1});

  ProductCartItem copyWith({int? quantity}) =>
      ProductCartItem(product: product, quantity: quantity ?? this.quantity);

  Map<String, dynamic> toJson() => {
    'product': product.toJson(),
    'quantity': quantity,
  };

  factory ProductCartItem.fromJson(Map<String, dynamic> map) => ProductCartItem(
    product: ProductModel.fromJson(map['product'] as Map<String, dynamic>),
    quantity: (map['quantity'] as num?)?.toInt() ?? 1,
  );
}
