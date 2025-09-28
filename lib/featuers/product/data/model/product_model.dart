class ProductsResponseModel {
  List<ProductModel> products;
  int total;
  int skip;
  int limit;

  ProductsResponseModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  ProductsResponseModel.fromJson(Map<String, dynamic> json)
    : products = (json['products'] as List? ?? [])
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total = (json['total'] as num?)?.toInt() ?? 0,
      skip = (json['skip'] as num?)?.toInt() ?? 0,
      limit = (json['limit'] as num?)?.toInt() ?? 0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['products'] = products.map((v) => v.toJson()).toList();
    data['total'] = total;
    data['skip'] = skip;
    data['limit'] = limit;
    return data;
  }
}

class ProductModel {
  int id;
  String title;
  String description;
  String category;
  double price;
  double discountPercentage;
  double rating;
  int stock;
  List<String> tags;
  String brand;
  String sku;
  int weight;
  DimensionsModel dimensions;
  String warrantyInformation;
  String shippingInformation;
  String availabilityStatus;
  List<ReviewModel> reviews;
  String returnPolicy;
  int minimumOrderQuantity;
  MetaModel meta;
  String thumbnail;
  List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.thumbnail,
    required this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
    : id = (json['id'] as num?)?.toInt() ?? 0,
      title = (json['title'] as String?) ?? '',
      description = (json['description'] as String?) ?? '',
      category = (json['category'] as String?) ?? '',
      price = (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage =
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating = (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock = (json['stock'] as num?)?.toInt() ?? 0,
      tags = List<String>.from(
        (json['tags'] as List? ?? const []).map((e) => e.toString()),
      ),
      brand = (json['brand'] as String?) ?? '',
      sku = (json['sku'] as String?) ?? '',
      weight = (json['weight'] as num?)?.toInt() ?? 0,
      dimensions = json['dimensions'] == null
          ? DimensionsModel(width: 0, height: 0, depth: 0)
          : DimensionsModel.fromJson(json['dimensions']),
      warrantyInformation = (json['warrantyInformation'] as String?) ?? '',
      shippingInformation = (json['shippingInformation'] as String?) ?? '',
      availabilityStatus = (json['availabilityStatus'] as String?) ?? '',
      reviews = (json['reviews'] as List? ?? [])
          .map((e) => ReviewModel.fromJson(e))
          .toList(),
      returnPolicy = (json['returnPolicy'] as String?) ?? '',
      minimumOrderQuantity =
          (json['minimumOrderQuantity'] as num?)?.toInt() ?? 0,
      meta = json['meta'] == null
          ? MetaModel(createdAt: '', updatedAt: '', barcode: '', qrCode: '')
          : MetaModel.fromJson(json['meta']),
      thumbnail = (json['thumbnail'] as String?) ?? '',
      images = List<String>.from(
        (json['images'] as List? ?? const []).map((e) => e.toString()),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['price'] = price;
    data['discountPercentage'] = discountPercentage;
    data['rating'] = rating;
    data['stock'] = stock;
    data['tags'] = tags;
    data['brand'] = brand;
    data['sku'] = sku;
    data['weight'] = weight;
    data['dimensions'] = dimensions.toJson();
    data['warrantyInformation'] = warrantyInformation;
    data['shippingInformation'] = shippingInformation;
    data['availabilityStatus'] = availabilityStatus;
    data['reviews'] = reviews.map((v) => v.toJson()).toList();
    data['returnPolicy'] = returnPolicy;
    data['minimumOrderQuantity'] = minimumOrderQuantity;
    data['meta'] = meta.toJson();
    data['thumbnail'] = thumbnail;
    data['images'] = images;
    return data;
  }
}

class DimensionsModel {
  double width;
  double height;
  double depth;

  DimensionsModel({
    required this.width,
    required this.height,
    required this.depth,
  });

  DimensionsModel.fromJson(Map<String, dynamic> json)
    : width = (json['width'] as num?)?.toDouble() ?? 0.0,
      height = (json['height'] as num?)?.toDouble() ?? 0.0,
      depth = (json['depth'] as num?)?.toDouble() ?? 0.0;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['width'] = width;
    data['height'] = height;
    data['depth'] = depth;
    return data;
  }
}

class ReviewModel {
  int rating;
  String comment;
  String date; // ISO8601 as string
  String reviewerName;
  String reviewerEmail;

  ReviewModel({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  ReviewModel.fromJson(Map<String, dynamic> json)
    : rating = (json['rating'] as num?)?.toInt() ?? 0,
      comment = (json['comment'] as String?) ?? '',
      date = (json['date'] as String?) ?? '',
      reviewerName = (json['reviewerName'] as String?) ?? '',
      reviewerEmail = (json['reviewerEmail'] as String?) ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['comment'] = comment;
    data['date'] = date;
    data['reviewerName'] = reviewerName;
    data['reviewerEmail'] = reviewerEmail;
    return data;
  }
}

class MetaModel {
  String createdAt; // ISO8601 as string
  String updatedAt; // ISO8601 as string
  String barcode;
  String qrCode;

  MetaModel({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  MetaModel.fromJson(Map<String, dynamic> json)
    : createdAt = (json['createdAt'] as String?) ?? '',
      updatedAt = (json['updatedAt'] as String?) ?? '',
      barcode = (json['barcode'] as String?) ?? '',
      qrCode = (json['qrCode'] as String?) ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['barcode'] = barcode;
    data['qrCode'] = qrCode;
    return data;
  }
}
