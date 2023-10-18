import 'dart:convert';

import 'package:auto_point_mobile/models/cart_model.dart';
import 'package:auto_point_mobile/models/product_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/product_controller.dart';
import '../../utils/constants.dart';
import '../api/api_client.dart';

class CartItemRepo extends GetxService{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  CartItemRepo({required this.apiClient, required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList){
    cart = [];
    var time = DateTime.now().toString();
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    //getCartList();
  }

  List<CartModel> getCartList(){
    List<String> carts = [];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      
    }
    
    List<CartModel> cartList = [];
    
    carts.forEach((element) { 
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    
    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY)){
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY)!;
    }
    List<CartModel> cartListHistory = [];

    cartHistory.forEach((element) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartListHistory;
  }

  void addToCartHistoryList(){
    for(int i = 0; i< cart.length; i++){
      cartHistory.add(cart[i]);
    }

    removeCart();

    sharedPreferences.setStringList(AppConstants.CART_HISTORY, cartHistory);
  }

  void removeCart(){
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void removeCartHistory(){
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY);
  }

  void removeAllFromSharedPreferences(){
    removeCart();
    removeCartHistory();
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.EMAIL);
    sharedPreferences.remove(AppConstants.PASSWORD);
  }
  
  Future<Response> getCartItemsList() async{
    return await apiClient.getData(AppConstants.GET_CART_ALL);
  }

  ProductModel findProductById(int id){
    return Get.find<ProductController>().productList.firstWhere((element) => element.product.id == id.toString());
  }



}