import 'package:auto_point_mobile/data/entities/product.dart';
import 'package:auto_point_mobile/models/product_model.dart';

class CartModel{
  final ProductModel product;
  final int quantity;
  final num eurPrice;
  String time;

  CartModel({required this.product, required this.quantity, required this.time, required this.eurPrice});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'] as int,
      eurPrice: json['eurPrice'] as num,
      time: (json['time'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'eurPrice' : eurPrice,
      'time': time.toString(),
    };
  }
}