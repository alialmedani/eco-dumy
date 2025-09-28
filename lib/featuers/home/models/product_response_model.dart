// import 'package:json_annotation/json_annotation.dart';

// part 'product_response_model.g.dart';

// @JsonSerializable()
// class ProductResponse {
//   @JsonKey(name: 'products')
//   List<Product?>? products;

//   int? total;
//   int? skip;
//   int? limit;

//   ProductResponse({this.products, this.total, this.skip, this.limit});

//   factory ProductResponse.fromJson(Map<String, dynamic> json) =>
//       _$ProductResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
// }

// @JsonSerializable()
// class Product {
//   int? id;
//   String? title;
//   String? description;
//   String? category;
//   double? price;

//   @JsonKey(name: 'discountPercentage')
//   double? discountPercentage;

//   double? rating;
//   int? stock;
//   List<String>? tags;
//   String? brand;
//   String? sku;
//   double? weight;
//   Dimensions? dimensions;
//   String? warrantyInformation;
//   String? shippingInformation;
//   String? availabilityStatus;

//   List<Review>? reviews;
//   String? returnPolicy;
//   int? minimumOrderQuantity;
//   Meta? meta;
//   String? thumbnail;
//   List<String>? images;
//   bool isFavorite;    
//   int quantity;
//   Product(
//       {this.id,
//       this.title,
//       this.description,
//       this.category,
//       this.price,
//       this.discountPercentage,
//       this.rating,
//       this.stock,
//       this.tags,
//       this.brand,
//       this.sku,
//       this.weight,
//       this.dimensions,
//       this.warrantyInformation,
//       this.shippingInformation,
//       this.availabilityStatus,
//       this.reviews,
//       this.returnPolicy,
//       this.minimumOrderQuantity,
//       this.meta,
//       this.thumbnail,
//       this.images,
//       this.isFavorite = false,
//       this.quantity = 1
 
//       });

//   factory Product.fromJson(Map<String, dynamic> json) =>
//       _$ProductFromJson(json);

//   Map<String, dynamic> toJson() => _$ProductToJson(this);
// }

// @JsonSerializable()
// class Dimensions {
//   double? width;
//   double? height;
//   double? depth;

//   Dimensions({this.width, this.height, this.depth});

//   factory Dimensions.fromJson(Map<String, dynamic> json) =>
//       _$DimensionsFromJson(json);

//   Map<String, dynamic> toJson() => _$DimensionsToJson(this);
// }

// @JsonSerializable()
// class Review {
//   int? rating;
//   String? comment;
//   DateTime? date;
//   String? reviewerName;
//   String? reviewerEmail;

//   Review({
//     this.rating,
//     this.comment,
//     this.date,
//     this.reviewerName,
//     this.reviewerEmail,
//   });

//   factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

//   Map<String, dynamic> toJson() => _$ReviewToJson(this);
// }

// @JsonSerializable()
// class Meta {
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? barcode;
//   String? qrCode;

//   Meta({
//     this.createdAt,
//     this.updatedAt,
//     this.barcode,
//     this.qrCode,
//   });

//   factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

//   Map<String, dynamic> toJson() => _$MetaToJson(this);
// }
