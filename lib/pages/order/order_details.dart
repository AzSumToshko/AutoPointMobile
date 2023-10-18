import 'package:auto_point_mobile/data/entities/order.dart';
import 'package:auto_point_mobile/routes/route_helper.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/styles.dart';

class OrderDetails extends StatelessWidget {
  final directory;
  final OrderEntity order;
  const OrderDetails({Key? key,required this.directory, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(onPressed: () => Get.toNamed(RouteHelper.getInitial(directory)), icon: Icon(Icons.home,color: Colors.black,size: Dimensions.font26*1.2,)),
        ],
        backgroundColor: AppColors.mainColor,
        leading:IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios_new,color: Colors.black,size: Dimensions.font26*1.2,)),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Dimensions.height40*2,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.radius20) ,
                bottomRight: Radius.circular(Dimensions.radius20,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: Dimensions.width10,),
                Container(
                  height: Dimensions.height20*3,
                  width: Dimensions.height20*3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                  ),
                  child: Center(
                    child: Image.asset("assets/image/box.png",height: Dimensions.height40,),
                  ),
                ),
                SizedBox(width: Dimensions.width10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: Dimensions.height20,),
                    Text("Order ID: ${order.id}",style: robotoMedium.copyWith(
                      fontSize: Dimensions.font16
                    ),),
                    Text("Status: ${order.status}",style: robotoMedium.copyWith(
                        fontSize: Dimensions.font20
                    ),),
                  ],
                )
              ],
            ),
          ),

          SizedBox(height: Dimensions.height5*5,),

          Center(
            child: Padding(
              padding: EdgeInsets.only(left: Dimensions.width20),
              child: Text("Placed at ${order.deliveryDate}",),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: Dimensions.width20),
              child: Text("${order.addressOne}",maxLines: 1,style: robotoMedium.copyWith(
                fontSize: Dimensions.font16
              ),),
            ),
          ),

          SizedBox(height: Dimensions.height5*5,),

          Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: Text("Order contact phone",),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: Text("${order.phoneNumber}",style: robotoMedium.copyWith(
                      fontSize: Dimensions.font16
                  ),),
                ),
              ],
            ),
          ),

          SizedBox(height: Dimensions.height5*5,),

          Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: Text("Order contact email",),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: Text("${order.email}",style: robotoMedium.copyWith(
                      fontSize: Dimensions.font16
                  ),),
                ),
              ],
            ),
          ),

          SizedBox(height: Dimensions.height5*5,),

          Center(
            child: Padding(
              padding: EdgeInsets.only(left: Dimensions.width20),
              child: Text("Order-er full name",),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: Dimensions.width20),
              child: Text("${order.fullName}",maxLines: 1,style: robotoMedium.copyWith(
                  fontSize: Dimensions.font16
              ),),
            ),
          ),

          SizedBox(height: Dimensions.height30,),

          Padding(
            padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
            child: Container(
              height: 2,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),

          SizedBox(height: Dimensions.height20,),

          Center(child: Text("Order Details",style: robotoBold)),

          SizedBox(height: Dimensions.height20,),
          Row(
            children: [
              Row(
                children: [
                  Text("Payment Method",style: robotoMedium.copyWith(
                      color: AppColors.mainColor,
                      fontSize: Dimensions.font16
                  )),
                  Icon(order.paymentMethod.toLowerCase()=="card"?Icons.paypal:Icons.attach_money,color: AppColors.mainColor,size: Dimensions.height40,),
                ],
              ),
              SizedBox(width: Dimensions.width10,),
              Row(
                children: [
                  Text("Delivery Type",style: robotoMedium.copyWith(
                      color: AppColors.mainColor,
                      fontSize: Dimensions.font16
                  )),
                  Icon(order.deliveryType.toLowerCase()=="fast"?Icons.fast_forward:Icons.free_breakfast,color: AppColors.mainColor,size: Dimensions.height40,),
                  Text(order.deliveryType,style: robotoMedium.copyWith(
                      fontSize: Dimensions.font16,
                      color: AppColors.mainColor
                  ),),
                ],
              ),
            ],
          ),

          SizedBox(height: Dimensions.height30,),

          Center(
            child: Container(
              width: Dimensions.screenWidth - Dimensions.width10,
              padding: EdgeInsets.symmetric(vertical: Dimensions.height20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Items Count",style: robotoMedium.copyWith(
                            fontSize: Dimensions.font16
                        ),),
                        Text(order.productsCount.toString(),style: robotoMedium.copyWith(
                            fontSize: Dimensions.font16
                        ),),
                      ],
                    ),
                  ),

                  SizedBox(height: Dimensions.height20,),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sub Total ",style: robotoMedium.copyWith(
                            fontSize: Dimensions.font16
                        ),),
                        Text(order.deliveryType.toLowerCase() =="free"?"${order.total} BGN":"${order.total-12} BGN",style: robotoMedium.copyWith(
                            fontSize: Dimensions.font16
                        ),),
                      ],
                    ),
                  ),

                  SizedBox(height: Dimensions.height20,),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delivery tax: ",style: robotoMedium.copyWith(
                            fontSize: Dimensions.font16
                        ),),
                        Text(order.deliveryType.toLowerCase()=="free"?"0.00 BGN":"12.00 BGN",style: robotoMedium.copyWith(
                            fontSize: Dimensions.font16
                        ),),
                      ],
                    ),
                  ),

                  SizedBox(height: Dimensions.height20,),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Price ",style: robotoMedium.copyWith(
                            fontSize: Dimensions.font16,
                            color: Colors.white
                        ),),
                        Text("${order.total} BGN",style: robotoMedium.copyWith(
                            fontSize: Dimensions.font16,
                            color: Colors.white
                        ),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
