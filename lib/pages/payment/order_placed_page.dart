import 'package:auto_point_mobile/controllers/payment_controller.dart';
import 'package:auto_point_mobile/routes/route_helper.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/cartItem_controller.dart';
import '../../utils/dimensions.dart';

class OrderSuccessPage extends StatelessWidget {
  final directory;
  final int orderID;
  final String status;
  const OrderSuccessPage({Key? key, required this.orderID, required this.status, required this.directory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartItemController>().addToHistoryOnly();
    Get.find<CartItemController>().clearWithoutUpdate();
    Get.find<CartItemController>().clearCartWithoutUpdate();
    Get.find<PaymentController>().setLoadingStateWithoutUpdate(false);

    if(status == "In Processing"){
      Future.delayed(Duration(seconds: 1), (){
        // Get.dialog(PaymentFailedDialog(orderID: orderID), barrierDismissible: false);
      });
    }

    return WillPopScope(
      onWillPop: ()async {
        // Return true to allow the back button
        return false;
      },
      child: Scaffold(
        body: Center(
          child: SizedBox(width: Dimensions.screenWidth, child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(status == "Pending" ? "assets/image/checked.png" : "assets/image/warning.png", width: Dimensions.width20*5, height: Dimensions.height20*5,),

                SizedBox(height: Dimensions.height45,),

                Text(
                  status == "Pending" ? "You placed the order successfully" : "Your order failed",
                  style: TextStyle(fontSize: Dimensions.font20),
                ),

                SizedBox(height: Dimensions.height20,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.height20,
                  vertical: Dimensions.height10),
                  child: Text(
                    status == "Pending" ? "Successful order" : "Failed order",
                    style: TextStyle(fontSize: Dimensions.font20,
                    color: Theme.of(context).disabledColor),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: Dimensions.height10,),

                Padding(
                  padding: EdgeInsets.all(Dimensions.height10),
                  child: GestureDetector(
                    onTap: (){
                      Get.offAllNamed(RouteHelper.getInitial(directory));
                    },
                    child: Center(
                      child: Container(
                        height: Dimensions.height40*1.5,
                        width: Dimensions.screenWidth - Dimensions.width40,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius15/2)
                        ),

                        child: Center(
                          child: Text(
                            "Back to Home",style: TextStyle(fontSize: Dimensions.font20,color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),),
        ),
      ),
    );
  }
}
