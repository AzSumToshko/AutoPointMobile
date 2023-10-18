import 'package:auto_point_mobile/base/custom_loader.dart';
import 'package:auto_point_mobile/controllers/order_controller.dart';
import 'package:auto_point_mobile/controllers/payment_controller.dart';
import 'package:auto_point_mobile/controllers/user_controller.dart';
import 'package:auto_point_mobile/pages/payment/payment_page.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cartItem_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import 'order_placed_page.dart';

class MakePaymentPage extends StatefulWidget {
  final directory;
  const MakePaymentPage({Key? key,required this.directory}) : super(key: key);

  @override
  State<MakePaymentPage> createState() => _MakePaymentPageState();
}

class _MakePaymentPageState extends State<MakePaymentPage> {

  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _postcode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(builder: (paymentController){
      return paymentController.isLoading ? Scaffold(body: CustomLoader()) : Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          leading: GestureDetector(onTap:(){Get.back();},child: Icon(Icons.arrow_back_ios_new)),
          title: const Text("Payment"),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height30,),
              Center(
                child: Container(
                  height: 70,
                  width: Dimensions.screenWidth - (Dimensions.width10 + Dimensions.width10),

                  padding: EdgeInsets.only(left: Dimensions.width40,right: Dimensions.width40),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(text: "Delivery info",size: Dimensions.font26,),
                    ],
                  ),
                ),
              ),

              SizedBox(height: Dimensions.height30,),
              AppTextField(textController: _phoneNumber, hintText: "Your Phone number", icon: Icons.map),

              SizedBox(height: Dimensions.height35,),
              AppTextField(textController: _city, hintText: "City", icon: Icons.person),

              SizedBox(height: Dimensions.height35,),
              AppTextField(textController: _postcode, hintText: "PostCode", icon: Icons.person),



              SizedBox(height: Dimensions.height45,),
              Center(
                child: Container(
                  height: 70,
                  width: Dimensions.screenWidth - (Dimensions.width10 + Dimensions.width10),

                  padding: EdgeInsets.only(left: Dimensions.width40,right: Dimensions.width40),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(text: "Payment method",size: Dimensions.font26,),
                    ],
                  ),
                ),
              ),

              SizedBox(height: Dimensions.height30,),
              GestureDetector(
                onTap: () async {
                  if(_phoneNumber.text.isEmpty){
                    Get.snackbar("Empty Field", "Field phone number is required!",backgroundColor: Colors.red,colorText: Colors.white);
                  }else if(_phoneNumber.text.length < 10 || _phoneNumber.text.length > 16){
                    Get.snackbar("Invalid Field", "The phone number you have typed is not correct!",backgroundColor: Colors.red,colorText: Colors.white);
                  }else if(_city.text.isEmpty){
                    Get.snackbar("Empty Field", "Field city is required!",backgroundColor: Colors.red,colorText: Colors.white);
                  }else if(_postcode.text.isEmpty){
                    Get.snackbar("Empty Field", "Field postcode is required!",backgroundColor: Colors.red,colorText: Colors.white);
                  }else{

                    Get.find<OrderController>().setCity(_city.text);
                    Get.find<OrderController>().setPhoneNumber(_phoneNumber.text);
                    Get.find<OrderController>().setPostCode(_postcode.text);
                    //Get.find<OrderController>().setPaymentMethod("cash");

                    //paymentController.setLoadingState(true);

                    //await Get.find<OrderController>().placeOrder();
                  }
                },
                child: Center(
                  child: Container(
                    height: Dimensions.height35*2,
                    width: Dimensions.screenWidth - (Dimensions.width20 + Dimensions.width20),

                    padding: EdgeInsets.only(left: Dimensions.width40,right: Dimensions.width40),

                    decoration:BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFe8e8e8),
                            blurRadius: 5.0,
                            offset: Offset(0, 3.5),
                          ),
                          BoxShadow(
                            color: Color(0xFFe8e8e8),
                            offset: Offset(-3.5, 0),
                          ),
                          BoxShadow(
                            color: Color(0xFFe8e8e8),
                            offset: Offset(3.5, 0),
                          ),
                          BoxShadow(
                            color: Color(0xFFe8e8e8),
                            blurRadius: 5.0,
                            offset: Offset(0, -3.5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                        color: Colors.white
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(text: "On delivery"),
                        Icon(Icons.payment),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: Dimensions.height30,),
              GestureDetector(
                onTap: () async {
                  if(_phoneNumber.text.isEmpty){
                    Get.snackbar("Empty Field", "Field phone number is required!",backgroundColor: Colors.red,colorText: Colors.white);
                  }else if(_phoneNumber.text.length < 10 || _phoneNumber.text.length > 16){
                    Get.snackbar("Invalid Field", "The phone number you have typed is not correct!",backgroundColor: Colors.red,colorText: Colors.white);
                  }else if(_city.text.isEmpty){
                    Get.snackbar("Empty Field", "Field city is required!",backgroundColor: Colors.red,colorText: Colors.white);
                  }else if(_postcode.text.isEmpty){
                    Get.snackbar("Empty Field", "Field postcode is required!",backgroundColor: Colors.red,colorText: Colors.white);
                  }else{

                    Get.find<OrderController>().setCity(_city.text);
                    Get.find<OrderController>().setPhoneNumber(_phoneNumber.text);
                    Get.find<OrderController>().setPostCode(_postcode.text);

                    paymentController.setLoadingState(true);

                    //await Get.find<OrderController>().placeOrder();

                    Get.to(PaypalPayment(
                        onFinish: (){
                          Get.find<OrderController>().updateOrder();

                          Get.to(OrderSuccessPage(orderID: Get.find<OrderController>().order!.id!, status: Get.find<OrderController>().order!.status, directory: widget.directory));
                        },
                        items: Get.find<CartItemController>().getItems.map((item) => {
                          "name": item.product.product.name,
                          "quantity": item.quantity,
                          "price": item.eurPrice,
                          "currency": "EUR"
                        }).toList(),

                        totalAmount: Get.find<CartItemController>().totalAmountEUR.toStringAsFixed(2),
                        subTotalAmount: Get.find<CartItemController>().totalAmountEUR.toStringAsFixed(2),
                        userFirstName: Get.find<UserController>().user!.firstName!,
                        userLastName: Get.find<UserController>().user!.lastName!,
                        addressCity: Get.find<OrderController>().order!.city,
                        addressStreet: Get.find<OrderController>().order!.addressOne,
                        addressState: "Bulgaria",
                        addressCountry: "Bulgaria",
                        addressZipCode: Get.find<OrderController>().order!.postcode,
                        addressPhoneNumber: Get.find<OrderController>().order!.phoneNumber));
                  }
                },
                child: Center(
                  child: Container(
                    height: Dimensions.height35*2,
                    width: Dimensions.screenWidth - (Dimensions.width20 + Dimensions.width20),

                    padding: EdgeInsets.only(left: Dimensions.width40,right: Dimensions.width40),

                    decoration:BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFe8e8e8),
                            blurRadius: 5.0,
                            offset: Offset(0, 3.5),
                          ),
                          BoxShadow(
                            color: Color(0xFFe8e8e8),
                            offset: Offset(-3.5, 0),
                          ),
                          BoxShadow(
                            color: Color(0xFFe8e8e8),
                            offset: Offset(3.5, 0),
                          ),
                          BoxShadow(
                            color: Color(0xFFe8e8e8),
                            blurRadius: 5.0,
                            offset: Offset(0, -3.5),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                        color: Colors.white
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(text: "PayPal"),
                        Icon(Icons.payment),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

