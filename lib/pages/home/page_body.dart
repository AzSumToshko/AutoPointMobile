import 'dart:io';

import 'package:auto_point_mobile/controllers/product_controller.dart';
import 'package:auto_point_mobile/routes/route_helper.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/utils/dimensions.dart';
import 'package:auto_point_mobile/widgets/app_column.dart';
import 'package:auto_point_mobile/widgets/big_text.dart';
import 'package:auto_point_mobile/widgets/icon_and_text_widget.dart';
import 'package:auto_point_mobile/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product_model.dart';

class PageBody extends StatefulWidget {
  final directory;

  const PageBody({Key? key, required this.directory}) : super(key: key);

  @override
  State<PageBody> createState() => _PageBodyState(directory: directory);
}

class _PageBodyState extends State<PageBody> {

  final directory;

  _PageBodyState({required this.directory});

  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page ?? _currentPageValue;
      });
    });
  }

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(init:Get.find<ProductController>() ,builder: (products){
      return products.isLoaded ? Column(
        children: [
          //slider
          Container(
            height: Dimensions.pageView,
            child: PageView.builder(
                controller: pageController,
                itemCount: products.productList.length >= 7 ? 7 : products.productList.length,
                itemBuilder: (context, position){

                  return _buildPageItem(position, products.productList[position]);
                }),
          ),

          //dots
          DotsIndicator(
            dotsCount: products.productList.length <= 0 ? 1 : products.productList.length >= 7 ? 7 : products.productList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          ),

          //populat text
          SizedBox(height: Dimensions.height30,),
          Container(
            margin: EdgeInsets.only(left: Dimensions.width30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                BigText(text: "All"),
                SizedBox(width: Dimensions.width20,),
                Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child:  BigText(text: ".",color: Colors.black26,),
                ),
                SizedBox(width: Dimensions.width20,),
                Container(
                  child: SmallText(text: "products",),
                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.height10,),
          //list of food and images
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: products.productList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommended(index, directory, "main"));
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
                                image: FileImage(File(directory+ "/image/" + products.productList[index].product.id + '.png')),
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
                                  BigText(text: products.productList[index].product.name),
                                  SizedBox(height: Dimensions.height10,),
                                  Center(child: SmallText(text: "цена: ${products.productList[index].product.price}BGN.")),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndTextWidget(icon: Icons.card_membership_outlined,
                                            text: products.productList[index].product.typeOfProduct == "Exhaust system" ? "Exhaust": products.productList[index].product.typeOfProduct,
                                            iconColor: AppColors.mainColor),
                                        SizedBox(width: Dimensions.width3,),
                                        IconAndTextWidget(icon: Icons.inventory,
                                            text: "In Stock",
                                            iconColor: AppColors.mainColor),
                                      ]
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
          Container(height: Dimensions.height30*1.70,)
        ],
      ): Column(
        children: [

          SizedBox(
            width: Dimensions.width45 * 6.3,
            height: Dimensions.height45 * 6.3,
          ),

          //The loading animation
          Center(
            child: CircularProgressIndicator(
              color: AppColors.mainColor,
            ),
          )
        ],
      );
    });
  }

  Widget _buildPageItem(int index, ProductModel product){
    Matrix4 matrix = new Matrix4.identity();
    if(index == _currentPageValue.floor()){
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) /2;
      matrix = Matrix4.diagonal3Values(1, currScale ,1);
      matrix = Matrix4.diagonal3Values(1, currScale ,1)..setTranslationRaw(0, currTrans, 0);

    }else if(index == _currentPageValue.floor() + 1){
      var currScale = _scaleFactor + (_currentPageValue-index+1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) /2;
      matrix = Matrix4.diagonal3Values(1, currScale ,1);
      matrix = Matrix4.diagonal3Values(1, currScale ,1)..setTranslationRaw(0, currTrans, 0);

    }else if(index == _currentPageValue.floor() - 1){
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) /2;
      matrix = Matrix4.diagonal3Values(1, currScale ,1);
      matrix = Matrix4.diagonal3Values(1, currScale ,1)..setTranslationRaw(0, currTrans, 0);

    }else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale ,1)..setTranslationRaw(0, _height * (1 - _scaleFactor)/2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [

          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getDetails(index, directory));
            },
            child: Container(
              height: _height,
              margin: EdgeInsets.only(left: Dimensions.width5, right: Dimensions.width5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor,
                image: DecorationImage(
                    image: FileImage(File(directory+ "/image/" + product.product.id + '.png')),
                    fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width25, right: Dimensions.width25, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ]

              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15,left: Dimensions.width15,right: Dimensions.width15),
                child: AppColumn(productModel: product),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
