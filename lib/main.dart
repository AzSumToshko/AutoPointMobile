import 'dart:io';

import 'package:auto_point_mobile/controllers/cartItem_controller.dart';
import 'package:auto_point_mobile/controllers/payment_controller.dart';
import 'package:auto_point_mobile/controllers/product_controller.dart';
import 'package:auto_point_mobile/controllers/user_controller.dart';
import 'package:auto_point_mobile/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'data/entities/user.dart';
import 'helpers/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();

  final Directory directory = await getApplicationDocumentsDirectory();
  runApp(MyApp(directory: directory,));
}

class MyApp extends StatelessWidget {
  final Directory directory;
  const MyApp({super.key, required this.directory});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoPoint Mobile',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'AutoPoint Mobile', directory: directory,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Directory directory;
  const MyHomePage({super.key, required this.title, required this.directory});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(directory: directory);
}

class _MyHomePageState extends State<MyHomePage> {
  final Directory directory;
  late final List<User> users;
  bool isLoading = false;

  _MyHomePageState({required this.directory});

  @override
  Widget build(BuildContext context) {
    Get.find<CartItemController>().getCartData();
    Get.find<PaymentController>();
    return GetBuilder<ProductController>(builder: (_){
      return GetBuilder<UserController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AutoPoint Mobile',
          //home: SignInPage(directory: directory.path,),
          initialRoute: RouteHelper.getSplash(directory.path),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
