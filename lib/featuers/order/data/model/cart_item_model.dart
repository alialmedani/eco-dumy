class ProductCartItem {
  final int id;
  final String title;
  final String thumbnail;
  final double price;
  final int quantity;

  const ProductCartItem({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    this.quantity = 1,
  });

  ProductCartItem copyWith({int? quantity}) => ProductCartItem(
    id: id,
    title: title,
    thumbnail: thumbnail,
    price: price,
    quantity: quantity ?? this.quantity,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'thumbnail': thumbnail,
    'price': price,
    'quantity': quantity,
  };

  factory ProductCartItem.fromJson(Map<String, dynamic> map) => ProductCartItem(
    id: (map['id'] as num).toInt(),
    title: map['title'] as String? ?? '',
    thumbnail: map['thumbnail'] as String? ?? '',
    price: (map['price'] as num?)?.toDouble() ?? 0.0,
    quantity: (map['quantity'] as num?)?.toInt() ?? 1,
  );
}
