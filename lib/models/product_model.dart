import 'package:auto_point_mobile/data/entities/product.dart';

class ProductModel {
  late final Product product;
  late final int commentsCount;

  ProductModel(
      {required this.product,
      required this.commentsCount});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      product: Product.fromJson(json['product']),
      commentsCount: json['commentsCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'commentsCount': commentsCount,
    };
  }

}