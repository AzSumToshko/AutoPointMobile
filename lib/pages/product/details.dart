import 'dart:io';

import 'package:auto_point_mobile/controllers/cartItem_controller.dart';
import 'package:auto_point_mobile/controllers/product_controller.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/utils/dimensions.dart';
import 'package:auto_point_mobile/widgets/app_column.dart';
import 'package:auto_point_mobile/widgets/app_icon.dart';
import 'package:auto_point_mobile/widgets/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../widgets/big_text.dart';

class ProductDetails extends StatelessWidget {
  int pageId;
  final directory;

  ProductDetails({Key? key, required this.pageId, required this.directory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<ProductController>().productList[pageId];
    Get.find<ProductController>().initProduct(product, Get.find<CartItemController>());
    print("page id is : " + pageId.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.detailImgSize,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                image: DecorationImage(
                  image: FileImage(File(directory+ "/image/" + product.product.id + '.png')),)
              ),
            ),
          ),
          //image widget
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(onTap:(){
                  Get.back();
                  } ,child: AppIcon(
                  icon: Icons.arrow_back_ios_new,
                  iconColor: Colors.white,
                  backgroundColor: Colors.transparent,
                iconSize: Dimensions.font26,
                size: Dimensions.height5*10,)),

                GetBuilder<ProductController>(builder: (products){
                  return GestureDetector(
                    onTap: (){
                      if(Get.find<ProductController>().totalItems >= 1){
                        Get.toNamed(RouteHelper.getCart(directory));
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(
                            icon: Icons.shopping_cart_sharp,
                          iconSize: Dimensions.font26,
                          size: Dimensions.height5*10,
                          backgroundColor: Colors.transparent,
                          iconColor: Colors.white,
                        ),
                        Get.find<ProductController>().totalItems >= 1
                            ? Positioned(
                              right: 3, top: 5,
                              child: AppIcon(
                                      icon: Icons.circle,
                                      size: Dimensions.font20,
                                      iconColor: Colors.transparent,
                                      backgroundColor: AppColors.secondaryColor,
                              ),
                            )
                            : Container(),
                        Get.find<ProductController>().totalItems >= 1
                            ? Positioned(
                          right: 9, top: 8.5,
                          child: BigText(
                            text: Get.find<ProductController>().totalItems.toString(),
                            size: 12,
                            color: AppColors.thirdColor,),
                        )
                            : Container(),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          //description
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.detailImgSize -20,
            child: Container(
              padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(productModel: product),
                  SizedBox(height: Dimensions.height20,),
                  BigText(text: "Details"),
                  SizedBox(height: Dimensions.height10,),
                  Expanded(
                    child: SingleChildScrollView(
                        child: ExpandableText(text: product.product.description)
                    ),
                  ),
                ],
              ),
            ),
          ),
          //expandable text
        ],
      ),
      bottomNavigationBar: GetBuilder<ProductController>(builder: (products){
        return Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20*2),
            topRight: Radius.circular(Dimensions.radius20*2),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  GestureDetector(onTap:(){
                    products.setQuantity(false);
                  } ,child: Icon(Icons.remove, color: Colors.grey,)),
                  SizedBox(width: Dimensions.width10,),
                  BigText(text: products.inCartItems.toString()),
                  SizedBox(width: Dimensions.width10,),
                  GestureDetector(onTap: (){
                    products.setQuantity(true);
                  },child: Icon(Icons.add, color:Colors.grey,)),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                products.addItem(product);
              },
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),

                child: BigText(
                      text: (product.product.price).toStringAsFixed(2) + "лв. | Добави", color: Colors.white,)
                ),
            ),
          ],
        ),
      );}),
    );
  }
}
