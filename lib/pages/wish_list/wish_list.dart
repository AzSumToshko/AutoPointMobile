import 'package:auto_point_mobile/base/custom_app_bar.dart';
import 'package:auto_point_mobile/base/no_data_page.dart';
import 'package:auto_point_mobile/controllers/product_controller.dart';
import 'package:auto_point_mobile/controllers/wish_list_controller.dart';
import 'package:auto_point_mobile/routes/route_helper.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/utils/dimensions.dart';
import 'package:auto_point_mobile/widgets/big_text.dart';
import 'package:auto_point_mobile/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';
import '../../controllers/cartItem_controller.dart';
import '../../models/product_model.dart';
import '../../utils/styles.dart';
import '../../widgets/app_icon.dart';

class WishList extends StatelessWidget {
  final directory;
  const WishList({Key? key, required this.directory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<ProductController>().initWishList(Get.find<CartItemController>());

    return GetBuilder<ProductController>(builder: (productController){
      return Scaffold(
        appBar: CustomAppBar(title: "Wish List", directory: directory, isBackButtonEnabled: false,actions: [
          GestureDetector(
            onTap: (){
              if(productController.totalItems >= 1){
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
                productController.totalItems >= 1
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
                productController.totalItems >= 1
                    ? Positioned(
                  right: 9, top: 8.5,
                  child: BigText(
                    text: productController.totalItems.toString(),
                    size: 12,
                    color: AppColors.thirdColor,),
                )
                    : Container(),
              ],
            ),
          )
        ],),
        body: GetBuilder<WishListController>(builder: (wishController){
          return wishController.wishList.isEmpty?SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Center(child: NoDataPage(text: "You dont have any item in the wish list!", directory: directory))
          ):Padding(
            padding: EdgeInsets.only(top: Dimensions.height20),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: wishController.wishList.length,
                itemBuilder: (context, index){
                  var entry = wishController.wishList.entries.elementAt(index);
                  int id = int.parse(entry.key);
                  ProductModel productModel = entry.value;
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommended(id, directory, "main"));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                      child: Row(
                        children: [
                          //image section
                          Container(
                            width: Dimensions.listViewImgSize,
                            height: Dimensions.listViewImgSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: AppColors.mainColor,
                              image: DecorationImage(
                                image: FileImage(File(directory+ "/image/" + productModel.product.id + '.png')),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          //text container
                          Expanded(
                            child: Container(
                              height: Dimensions.listViewTextContSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.radius20),
                                  bottomRight: Radius.circular(Dimensions.radius20),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(child: BigText(text: productModel.product.name)),
                                    SizedBox(height: Dimensions.height10,),
                                    Center(child: SmallText(text: "цена: ${productModel.product.price}BGN.")),
                                    SizedBox(height: Dimensions.height10,),
                                    InkWell(
                                      onTap: (){
                                        Get.find<ProductController>().addItemFromWishList(productModel);
                                        Get.find<ProductController>().update();
                                        wishController.update();
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.width5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(width: 1,color: AppColors.mainColor),
                                            borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                          ),
                                          child: Row(
                                            children: [
                                              Image.asset("assets/image/tracking.png", height: Dimensions.height15, width: Dimensions.height15, color: AppColors.mainColor,),
                                              SizedBox(width: Dimensions.width5,),
                                              Text("Add to cart",style: robotoMedium.copyWith(
                                                  fontSize: Dimensions.font12,
                                                  color: AppColors.mainColor
                                              ),),
                                            ],
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        }),
      );
    });
  }
}
