import 'package:auto_point_mobile/data/entities/order.dart';
import 'package:auto_point_mobile/pages/order/order_details.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/utils/dimensions.dart';
import 'package:auto_point_mobile/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/order_controller.dart';

class ViewOrder extends StatelessWidget {
  final directory;
  final bool isPending;
  const ViewOrder({
    Key? key,
    required this.isPending,
    required this.directory
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController){
          late List<OrderEntity> orderList;
            orderList = isPending
                ? orderController.pendingOrderList.reversed.toList()
                : orderController.orderList.reversed.toList();

          return SizedBox(
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width5, vertical: Dimensions.height5),
              child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      null;
                    },
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("order ID", style: robotoRegular.copyWith(
                                    fontSize: Dimensions.font12
                                  ),),
                                  SizedBox(width: Dimensions.width5,),
                                  Text("#${orderList[index].id.toString()}"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.width5),
                                    child: Text(orderList[index].status, style: robotoMedium.copyWith(
                                      fontSize: Dimensions.font12,
                                      color: Colors.white
                                    )),
                                  ),
                                  SizedBox(height: Dimensions.height5,),
                                  InkWell(
                                    onTap: (){
                                      Get.to(OrderDetails(directory: directory, order: orderList[index]));
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
                                          Text("View order",style: robotoMedium.copyWith(
                                            fontSize: Dimensions.font12,
                                            color: AppColors.mainColor
                                          ),),
                                        ],
                                      )
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.height10,)
                      ],
                    ),
                  );
                }
              ),
            ),
          );
      },),
    );
  }
}
