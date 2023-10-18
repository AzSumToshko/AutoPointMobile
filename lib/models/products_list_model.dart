
import '../data/entities/product.dart';

class ProductsList{
  late List<Product> _products;
  List<Product> get products => _products;

  ProductsList({required products}){
    this._products = _products;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[''] = this._products;
    return data;
  }
}