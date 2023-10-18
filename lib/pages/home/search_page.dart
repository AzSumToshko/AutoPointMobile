import 'dart:io';

import 'package:auto_point_mobile/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_app_bar.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class SearchPage extends StatelessWidget {
  final Map<String,ProductModel> products;
  final directory;
  SearchPage({Key? key, required this.products, required this.directory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Search results', directory: directory,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Dimensions.height10,),
            //list of food and images
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index){

                  var entry = products.entries.elementAt(index);
                  int id = int.parse(entry.key);

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
                                image: FileImage(File(directory+ "/image/" + entry.value.product.id + '.png')),
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
                                    BigText(text: entry.value.product.name),
                                    SizedBox(height: Dimensions.height10,),
                                    Center(child: SmallText(text: "цена: ${entry.value.product.price}BGN.")),
                                    SizedBox(height: Dimensions.height10,),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(icon: Icons.card_membership_outlined,
                                              text: entry.value.product.typeOfProduct == "Exhaust system" ? "Exhaust": entry.value.product.typeOfProduct,
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
          ],
        ),
      ),
    );
  }
}
