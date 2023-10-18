import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/utils/dimensions.dart';
import 'package:auto_point_mobile/widgets/app_icon.dart';
import 'package:auto_point_mobile/widgets/big_text.dart';
import 'package:auto_point_mobile/widgets/expandable_text.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/cartItem_controller.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/wish_list_controller.dart';
import '../../routes/route_helper.dart';

class RecommendedDetails extends StatelessWidget {
  final int pageId;
  final directory;
  final page;

  const RecommendedDetails({Key? key, this.directory, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<ProductController>().productList[pageId];
    Get.find<ProductController>().initProduct(product, Get.find<CartItemController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.height5*11,
            title: Row(
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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(

                width: double.maxFinite,
                padding: EdgeInsets.only(top: Dimensions.height5, bottom: Dimensions.height10),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                  )
                ),

                child: Center(child: BigText(size: Dimensions.font26,text: product.product.name),),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.orange,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(directory+ "/image/" + product.product.id + '.png')),)
              ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                  child: ExpandableText(text: product.product.description,),
                ),
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<ProductController>(builder: (products) {

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20*2.5,
                right: Dimensions.width20*2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                      products.setQuantity(false);
                    },
                    child: AppIcon(
                      icon: CupertinoIcons.minus,
                      iconColor: Colors.white,
                      backgroundColor: Colors.orange,
                      iconSize: Dimensions.icon24,
                    ),
                  ),
                  BigText(
                    text: product.product.price.toString() + "лв. X "+ products.inCartItems.toString(),
                    color: Colors.black,
                    size: Dimensions.font26,
                  ),
                  GestureDetector(
                      onTap: (){
                        products.setQuantity(true);
                      },
                    child: AppIcon(
                      icon: CupertinoIcons.add,
                      iconColor: Colors.white,
                      backgroundColor: Colors.orange,
                      iconSize: Dimensions.icon24,
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                  GetBuilder<WishListController>(builder: (wishController){
                    bool containsItem = false;
                    for (var entry in wishController.wishList.entries) {
                      var productModel = entry.value;
                      if (productModel.product.id == product.product.id) {
                        containsItem = true;
                        break;
                      }
                    }
                    return GestureDetector(
                      onTap: (){
                        if(!containsItem){
                          containsItem = true;
                          wishController.addToWishList(pageId.toString(),product);
                        }else{
                          containsItem = false;
                          wishController.removeFromWishList(pageId.toString(),product);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.favorite_outlined,
                          color: containsItem?AppColors.mainColor:Theme.of(context).disabledColor,
                          size: Dimensions.icon24,
                        ),
                      ),
                    );
                  }),
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

                      child: BigText(text: (product.product.price).toStringAsFixed(2) + "лв. | Add to cart", color: Colors.white,)),
                    ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
