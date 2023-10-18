import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_point_mobile/controllers/cartItem_controller.dart';
import 'package:auto_point_mobile/controllers/comment_controller.dart';
import 'package:auto_point_mobile/data/repository/product_repo.dart';
import 'package:auto_point_mobile/models/cart_model.dart';
import 'package:auto_point_mobile/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data/entities/product.dart';

class ProductController extends GetxController implements GetxService{
  final ProductRepo productRepo;
  late final Response? response;

  ProductController({required this.productRepo});
  List<dynamic> _productList = [];
  List<dynamic> get productList => _productList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 1;
  int get quantity => _quantity;

  late CartItemController _cart;

  int _inCartItems =0;
  int get inCartItems => _inCartItems + _quantity;

  String _searchInput = "";
  String get searchInput => _searchInput;

  @override
  void onInit() async{
    super.onInit();

    await getProductsFromAPI();

    List<ProductModel> productModels = [];

    for (var value in productList) {
      try{
        final imageData = await base64.decode(value.image);

        final fileName = '${value.id}.png'; // Change the extension if needed

        final directory = await getApplicationDocumentsDirectory();

        final file = File('${directory.path}/image/$fileName');
        await file.create(recursive: true);
        await file.writeAsBytes(imageData);

        int comments = 0;
        for(var item in Get.find<CommentController>().commentList){
          if(item.productId == int.parse(value.id)) {
            comments++;
          }
        }

        productModels.add(ProductModel(product: value, commentsCount: comments));

      }catch(e){
        print(e.toString());
      }
    }

    _productList = [];
    _productList = productModels;

    _isLoaded = true;
    update();
  }

  Future<void> getProductsFromAPI() async{
    response = await productRepo.getProductList();

    if(response?.statusCode == 200){
      _productList = [];

      for (var item in response?.body ) {
        Product product = Product.fromJson(item);
        _productList.add(product);
      }

      update();
    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      if(_quantity + _inCartItems < 20){
        _quantity++;
      }
    }else{
      if(_quantity + _inCartItems > 0){
        _quantity--;
      }else{
        Get.snackbar("Invalid action", "You cant reduce more.",
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
      }
    }

    update();
  }

  void initProduct(ProductModel productModel , CartItemController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(productModel);

    //print("exists or not : ${exist.toString()}");

    if(exist){
      _inCartItems = _cart.getQuantity(productModel);
    }

    //print("the quantity in the cart is : ${_inCartItems.toString()}");
  }

  Map<String, ProductModel> getProductsContaining(){
    Map<String, ProductModel> products = {};
    int indexGetter = 0;

    for(var item in productList){
      String productName = item.product.name.toLowerCase();
      String searchInputToLower = searchInput.toLowerCase();
      if(productName.contains(searchInputToLower)){
        products.putIfAbsent(indexGetter.toString(),() => item);
      }
      indexGetter++;
    }
    setSearchInput("");
    return products;
  }

  void setSearchInput(String input){
    _searchInput = input;
    update();
  }

  void initWishList(CartItemController cart){
    _cart = cart;
  }

  void successCartChange(){
    Get.snackbar("Cart changed", "You have changes in your cart.",
        backgroundColor: Colors.green,
        colorText: Colors.white
    );
  }

  void addItem(ProductModel product){
    _cart.addItem(product, quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    update();
  }

  void addItemFromWishList(ProductModel product){
    _cart.addItem(product, 1);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }
}