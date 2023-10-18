import 'package:auto_point_mobile/controllers/auth_controller.dart';
import 'package:auto_point_mobile/controllers/location_controller.dart';
import 'package:auto_point_mobile/controllers/payment_controller.dart';
import 'package:auto_point_mobile/controllers/product_controller.dart';
import 'package:auto_point_mobile/controllers/wish_list_controller.dart';
import 'package:auto_point_mobile/data/api/api_client.dart';
import 'package:auto_point_mobile/data/repository/auth_repo.dart';
import 'package:auto_point_mobile/data/repository/location_repo.dart';
import 'package:auto_point_mobile/data/repository/payment_repo.dart';
import 'package:auto_point_mobile/data/repository/product_repo.dart';
import 'package:auto_point_mobile/utils/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/cartItem_controller.dart';
import '../controllers/comment_controller.dart';
import '../controllers/order_controller.dart';
import '../controllers/user_controller.dart';
import '../data/repository/cart_item_repo.dart';
import '../data/repository/comment_repo.dart';
import '../data/repository/order_repo.dart';
import '../data/repository/user_repo.dart';
import '../data/repository/wish_list_repo.dart';

Future<void> init()async{
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => ProductRepo(apiClient:Get.find()));
  Get.lazyPut(() => UserRepo(apiClient:Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient:Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient:Get.find()));
  Get.lazyPut(() => CommentRepo(apiClient:Get.find()));
  Get.lazyPut(() => CartItemRepo(apiClient:Get.find() , sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient:Get.find() , sharedPreferences: Get.find()));
  Get.lazyPut(() => PaymentRepo(apiClient:Get.find() , sharedPreferences: Get.find()));
  Get.lazyPut(() => WishListRepo(apiClient:Get.find() , sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => CommentController(commentRepo: Get.find()));
  Get.lazyPut(() => CartItemController(cartItemRepo: Get.find()));
  Get.lazyPut(() => PaymentController(paymentRepo: Get.find()));
  Get.lazyPut(() => WishListController(wishListRepo: Get.find()));
}