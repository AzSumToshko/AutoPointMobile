import 'dart:convert';

import 'package:auto_point_mobile/data/repository/wish_list_repo.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';

class WishListController extends GetxController implements GetxService{
  final WishListRepo wishListRepo;

  WishListController({required this.wishListRepo});

  @override
  void onInit(){
    super.onInit();

    _wishList = wishListRepo.getWishList();
  }

  Map<String,ProductModel> _wishList = {};
  Map<String,ProductModel> get wishList => _wishList;

  Future<void> addToWishList(String id, ProductModel productModel)async {
    _wishList.putIfAbsent(id,() => productModel);

    wishListRepo.saveWishList(wishList);
    _wishList = wishListRepo.getWishList();
    update();
  }

  Future<void> removeFromWishList(String id, ProductModel productModel)async {
    _wishList.removeWhere((key, value) => value.product.id == productModel.product.id);

    wishListRepo.saveWishList(wishList);
    _wishList = wishListRepo.getWishList();
    update();
  }
}