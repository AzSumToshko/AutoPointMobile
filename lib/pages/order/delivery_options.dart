import 'package:auto_point_mobile/controllers/order_controller.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';

class DeliveryOptions extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;
  const DeliveryOptions({
    Key? key,
    required this.value,
    required this.title,
    required this.amount,
    required this.isFree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      return Row(
        children: [
          Radio(
            value: value,
            groupValue: orderController.deliveryType,
            onChanged: (value){ orderController.setDeliveryType(value!); },
            activeColor: AppColors.mainColor,

          ),
          SizedBox(width: Dimensions.width5,),
          Text(title,style: robotoRegular.copyWith(
            fontSize: Dimensions.font20
          ),),
          SizedBox(width: Dimensions.width5,),
          Text('(${value == 'take away' || isFree?'free':'12 BGN'})',style: robotoMedium.copyWith(
            fontSize: Dimensions.font12
          ),),
        ],
      );
    });
  }
}
