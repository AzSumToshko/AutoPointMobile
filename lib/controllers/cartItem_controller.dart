import 'package:auto_point_mobile/data/entities/cartItem.dart';
import 'package:auto_point_mobile/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/cart_item_repo.dart';
import '../models/cart_model.dart';

class CartItemController extends GetxController implements GetxService{
  final CartItemRepo cartItemRepo;
  late final Response? response;

  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => _items;

  CartItemController({required this.cartItemRepo});

  List<dynamic> _cartItemList = [];
  List<dynamic> get cartItemList => _cartItemList;

  List<CartModel> storageItems = [];
  /*
    only for stored and shared preferences
   */

  @override
  void onInit() async{
    super.onInit();

    await getCartItemsListFromAPI();

    update();
  }

  void clearCart(){
    cartItemRepo.removeCart();
    update();
  }

  void clearCartWithoutUpdate(){
    cartItemRepo.removeCart();
  }

  void clearCartHistory(){
    clearCart();
    cartItemRepo.removeCartHistory();
    update();
  }

  void addItem(ProductModel product, int quantity){
    var totalQuantity = 0;
    if(_items.containsKey(product.product.id)){

      _items.update(product.product.id, (value) {
        totalQuantity = value.productQuantity + quantity;
        return CartItem(productId: int.parse(product.product.id),
            id: "nothing",
            userId: 0,
            productQuantity: value.productQuantity + quantity >= 20 ? 20 : value.productQuantity + quantity);
      });

      if(totalQuantity <= 0){
        _items.remove(product.product.id);
      }
    }else{
      if(quantity > 0){
        _items.putIfAbsent(product.product.id, () {
          return CartItem(productId: int.parse(product.product.id),
              id: "nothing",
              userId: 0,
              productQuantity: quantity);
        });
      }else{
        Get.snackbar("Invalid count", "You should put at least one item in the cart.",
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
      }
    }

    cartItemRepo.addToCartList(getItems);

    update();
  }

  String getCartItemsIds(){
    //cartItemList - List ot quantity i productModel a puk productModel e product i negovite comments
    String items = "";
    for(var item in getItems){
      items += "${item.product.product.id} ";
    }

    return items.substring(0,items.length-1);
  }

  String getCartItemsQuantities(){
    //cartItemList - List ot quantity i productModel a puk productModel e product i negovite comments
    String items = "";
    for(var item in getItems){
      items += "${item.quantity} ";
    }

    return items.substring(0,items.length-1);
  }

  void successCartChange(){
    Get.snackbar("Cart changed", "You have changes in your cart.",
        backgroundColor: Colors.green,
        colorText: Colors.white
    );
  }

  bool existInCart(ProductModel productModel){
    if(_items.containsKey(productModel.product.id)){
      return true;
    }

    return false;
  }

  int getQuantity(ProductModel product){
    var quantity = 0;
    if(_items.containsKey(product.product.id)){
      _items.forEach((key, value) {
        if(key == product.product.id){
          quantity = value.productQuantity;
        }
      });
    }

    return quantity;
  }

  int get totalItems{
    var totalQuantity = 0;

    _items.forEach((key, value) {
      totalQuantity += value.productQuantity;
    });

    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e){
      ProductModel product = cartItemRepo.findProductById(e.value.productId);
      return CartModel(
        time: DateTime.now().toString(),
          product: product,
          quantity: e.value.productQuantity,
          eurPrice: (product.product.price/1.96).toPrecision(2),
      );
    }).toList();
  }

  num get totalAmount{
    num total = 0;

    _items.forEach((key, value) {
      total += value.productQuantity * cartItemRepo.findProductById(value.productId).product.price;
    });

    return total;
  }

  num get totalAmountEUR{
    num total = 0;

    for (var e in getItems) {
      total += (e.quantity * e.eurPrice);
    }

    return total;
  }

  void addToHistory(){
    cartItemRepo.addToCartHistoryList();
    clear();
    update();
  }

  void addToHistoryOnly(){
    cartItemRepo.addToCartHistoryList();
  }

  void clear(){
    _items = {};
    update();
  }

  void clearWithoutUpdate(){
    _items = {};
  }

  List<CartModel> getCartHistoryList(){
    return cartItemRepo.getCartHistoryList();
  }

  List<CartModel> getCartData(){
    setCart = cartItemRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items){
    storageItems = items;
    for(int i = 0; i < storageItems.length ; i++){
      _items.putIfAbsent(storageItems[i].product.product.id, () => CartItem(
          id: "none",
          productId: int.parse(storageItems[i].product.product.id),
          userId: -1,
          productQuantity: storageItems[i].quantity));
    }
  }

  Future<void> getCartItemsListFromAPI() async{
    response = await cartItemRepo.getCartItemsList();

    if(response?.statusCode == 200){
      _cartItemList = [];

      for (var item in response?.body ) {
        _cartItemList.add(CartItem.fromJson(item));
      }

      update();
    }
  }

  set setItems(Map<int, CartModel> setItems){
    Map<String,CartItem> itemsToInsert = {};
    _items = {};

    setItems.forEach((key, value) {
      itemsToInsert.putIfAbsent(key.toString(), () =>
      CartItem(id: "none", productId: int.parse(value.product.product.id), userId: -1, productQuantity: value.quantity));
    });

    _items = itemsToInsert;
  }
  
  void addToCartList(){
    cartItemRepo.addToCartList(getItems);
    update();
  }
}