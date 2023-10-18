import 'dart:async';

import 'package:auto_point_mobile/controllers/auth_controller.dart';
import 'package:auto_point_mobile/controllers/cartItem_controller.dart';
import 'package:auto_point_mobile/controllers/order_controller.dart';
import 'package:auto_point_mobile/controllers/user_controller.dart';
import 'package:auto_point_mobile/routes/route_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/comment_controller.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/wish_list_controller.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  final directory;

  const SplashScreen({Key? key, required this.directory}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState(directory: directory);
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final directory;
  _SplashScreenState({required this.directory});

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<WishListController>();
    await Get.find<CommentController>();
    await Get.find<ProductController>();
    await Get.find<AuthController>();
    await Get.find<UserController>();
    await Get.find<OrderController>();
    await Get.find<CartItemController>();
  }

  @override
  void initState(){
    super.initState();

    _loadResource();

    controller = AnimationController(
        vsync: this,
      duration: const Duration(seconds: 2)
    )..forward();

    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.linear
    );

    Timer(
      Duration(seconds: 3),
        ()=> Get.toNamed(RouteHelper.getInitial(directory))
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        // Return true to allow the back button
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: animation,
              child: Center(child: Image.asset("assets/image/banner-img.png", width: Dimensions.splashImg,))),

            Center(child: Image.asset("assets/image/logo.png", width: Dimensions.splashImg,)),
          ],
        ),
      ),
    );
  }
}
