
import 'package:auto_point_mobile/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final ProductModel productModel;
  const AppColumn({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: productModel.product.name, size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        //comments section
        Row(
          children: [
            /*Wrap(
              children: List.generate(5, (index) => Icon(Icons.star,size: 16, color: AppColors.mainColor,)),
            ),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "4.5"),*/
            SizedBox(width: Dimensions.width10,),
            SmallText(text: productModel.commentsCount.toString()),
            SizedBox(width: Dimensions.width10,),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: Dimensions.height20,),
        //category section
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconAndTextWidget(icon: Icons.card_membership_outlined,
                  text: productModel.product.typeOfProduct,
                  iconColor: AppColors.mainColor),
              SizedBox(width: Dimensions.width15,),
              IconAndTextWidget(icon: Icons.inventory,
                  text: "In Stock",
                  iconColor: AppColors.mainColor),
            ]
        ),
      ],
    );
  }
}
