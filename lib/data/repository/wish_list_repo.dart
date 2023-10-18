import 'dart:convert';

import 'package:auto_point_mobile/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class WishListRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  WishListRepo({
    required this.apiClient,
    required this.sharedPreferences
  });

  void saveWishList(Map<String, ProductModel> products){
    List<String> productsList = [];

    products.forEach((key, value) {
      return productsList.add(jsonEncode({
        "id": key,
        "product": value.toJson(),
      }));
    });

    sharedPreferences.setStringList(AppConstants.WISH_LIST, productsList);
  }

  Map<String, ProductModel> getWishList(){
    List<String> products = [];

    if(sharedPreferences.containsKey(AppConstants.WISH_LIST)){
      products = sharedPreferences.getStringList(AppConstants.WISH_LIST)!;
    }

    Map<String, ProductModel> productsMap = {};

    products.forEach((element) {
      final productJson = jsonDecode(element);
      final productId = productJson['id'];
      final product = ProductModel.fromJson(productJson['product']);
      productsMap[productId] = product;
    });

    return productsMap;
  }

  void removeWishList(){
    sharedPreferences.remove(AppConstants.WISH_LIST);
  }
}