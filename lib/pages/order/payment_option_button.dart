import 'package:auto_point_mobile/controllers/order_controller.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';

class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int index;

  const PaymentOptionButton({
    Key? key,
    required this.index,
    required this.subtitle,
    required this.title,
    required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController){
      bool _selected = orderController.paymentIndex == index;
      return InkWell(
        onTap: ()=>orderController.setPaymentIndex(index),
        child: Container(
          padding: EdgeInsets.only(bottom: Dimensions.height5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20/4),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200]!,
                    blurRadius: 5,
                    spreadRadius: 1
                )
              ]
          ),
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color: _selected?AppColors.mainColor:Theme.of(context).disabledColor,
            ),

            title: Text(
              title,
              style: robotoMedium.copyWith(
                  fontSize: Dimensions.font20
              ),
            ),

            subtitle: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: robotoRegular.copyWith(
                  fontSize: Dimensions.font16
              ),
            ),

            trailing: Icon(Icons.check_circle, color: _selected?AppColors.mainColor:Theme.of(context).cardColor,),
          ),
        ),
      );
    });
  }
}
