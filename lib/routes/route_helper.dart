
import 'package:auto_point_mobile/pages/address/add_address_page.dart';
import 'package:auto_point_mobile/pages/address/pick_address_map.dart';
import 'package:auto_point_mobile/pages/auth/sign_in_page.dart';
import 'package:auto_point_mobile/pages/auth/sign_up_page.dart';
import 'package:auto_point_mobile/pages/cart/cart_page.dart';
import 'package:auto_point_mobile/pages/home/home_page.dart';
import 'package:auto_point_mobile/pages/product/details.dart';
import 'package:auto_point_mobile/pages/product/recommended_details.dart';
import 'package:auto_point_mobile/pages/splash/splash_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const String initial = "/";
  static const String splash = "/splash";
  static const String recommended = "/recommended-product-details";
  static const String details = "/product-details";
  static const String cart = "/cart";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String addAddress = "/addAddress";
  static const String pickAddress = "/pickAddress";

  static String getInitial(directory) => "$initial?directory=${directory}";
  static String getSplash(directory) => "$splash?directory=${directory}";
  static String getRecommended(int pageId, directory, String page) => "$recommended?pageId=$pageId&directory=$directory&page=$page";
  static String getDetails(int pageId, directory) => "$details?pageId=$pageId&directory=$directory";
  static String getCart(directory) => "$cart?directory=$directory";
  static String getSignIn(directory) => "$signIn?directory=$directory";
  static String getSignUp(directory) => "$signUp?directory=$directory";
  static String getAddAddress(directory) => "$addAddress?directory=$directory";
  static String getPickAddress(directory) => "$pickAddress?directory=$directory";

  static List<GetPage> routes = [
    GetPage(name: initial, page: (){
      var directory = Get.parameters["directory"];
      return HomePage(directory: directory);
    },
    transition: Transition.fadeIn
    ),

    GetPage(name: splash, page: (){
      var directory = Get.parameters["directory"];
      return SplashScreen(directory: directory);
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: recommended, page: (){
      var pageId = Get.parameters["pageId"];
      var directory = Get.parameters["directory"];
      var page = Get.parameters["page"];
      return RecommendedDetails(pageId: int.parse(pageId!), directory: directory, page: page);
    },
      transition: Transition.fadeIn
    ),

    GetPage(name: details, page: (){
      var pageId = Get.parameters["pageId"];
      var directory = Get.parameters["directory"];
      return ProductDetails(pageId: int.parse(pageId!), directory: directory);
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: cart, page: (){
      var directory = Get.parameters["directory"];
      return CartPage(directory: directory);
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: signUp, page: (){
      var directory = Get.parameters["directory"];
      return SignUpPage(directory: directory);
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: signIn, page: (){
      var directory = Get.parameters["directory"];
      return SignInPage(directory: directory);
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: addAddress, page: (){
      var directory = Get.parameters["directory"];
      return AddAddressPage(directory: directory);
    },
        transition: Transition.fadeIn
    ),

    GetPage(name: pickAddress, page: (){
      var directory = Get.parameters["directory"];
      return PickAddressMap(directory: directory);
    },
        transition: Transition.fadeIn
    ),

  ];
}