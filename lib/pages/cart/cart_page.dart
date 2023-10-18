import 'package:auto_point_mobile/base/common_text_button.dart';
import 'package:auto_point_mobile/base/custom_app_bar.dart';
import 'package:auto_point_mobile/base/no_data_page.dart';
import 'package:auto_point_mobile/controllers/auth_controller.dart';
import 'package:auto_point_mobile/controllers/cartItem_controller.dart';
import 'package:auto_point_mobile/controllers/order_controller.dart';
import 'package:auto_point_mobile/controllers/payment_controller.dart';
import 'package:auto_point_mobile/controllers/product_controller.dart';
import 'package:auto_point_mobile/controllers/user_controller.dart';
import 'package:auto_point_mobile/pages/order/delivery_options.dart';
import 'package:auto_point_mobile/routes/route_helper.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/utils/dimensions.dart';
import 'package:auto_point_mobile/widgets/app_text_field.dart';
import 'package:auto_point_mobile/widgets/big_text.dart';
import 'package:auto_point_mobile/pages/order/payment_option_button.dart';
import 'package:auto_point_mobile/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';


import '../../base/custom_loader.dart';
import '../../utils/styles.dart';
import '../payment/order_placed_page.dart';
import '../payment/payment_page.dart';

class CartPage extends StatelessWidget {
  final directory;

  CartPage({Key? key, required this.directory}) : super(key: key);

  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _postcode = TextEditingController();

  @override
  Widget build(BuildContext context) {

    List<Widget> actions = [
      IconButton(
        icon: Icon(Icons.home, color: Colors.white,size: Dimensions.font26,), onPressed: () {Get.toNamed(RouteHelper.getInitial(directory));},),
    ];

    return GetBuilder<PaymentController>(builder: (paymentController){
      return paymentController.isLoading
          ? const Scaffold(body: CustomLoader())
          : Scaffold(
          appBar: CustomAppBar(title: "Cart", directory: directory,actions: actions,),
          body: Stack(
            children: [

              GetBuilder<CartItemController>(builder: (cart){
                var _cartList = cart.getItems;
                return cart.getItems.isNotEmpty ? Positioned(
                  top: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: 0,
                  child: Container(
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                              itemCount: _cartList.length,
                              itemBuilder: (_, index){
                                return Container(
                                  height: 100,
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          var detailsIndex = Get.find<ProductController>()
                                              .productList
                                              .indexOf(_cartList[index].product);

                                          Get.toNamed(RouteHelper.getRecommended(detailsIndex, directory, "cart"));
                                        },
                                        child: Container(
                                          width: Dimensions.height20*5,
                                          height: Dimensions.height20*5,
                                          margin: EdgeInsets.only(bottom: Dimensions.height10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(File(directory+ "/image/" + _cartList[index].product.product.id + '.png')),
                                              ),
                                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              color: Colors.white
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: Dimensions.width10,),

                                      Expanded(
                                        child: Container(
                                          height: Dimensions.height20*5,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(text: _cartList[index].product.product.name,color: Colors.black54,),

                                              SmallText(text: _cartList[index].product.product.typeOfProduct),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  BigText(text: "${_cartList[index].product.product.price.toStringAsFixed(2)}лв.",color: Colors.redAccent,),

                                                  Container(
                                                    padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10,left: Dimensions.width10,right: Dimensions.width10),

                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(onTap:(){
                                                          cart.addItem(_cartList[index].product, -1);
                                                        } ,child: Icon(Icons.remove, color: Colors.grey,)),
                                                        SizedBox(width: Dimensions.width10,),
                                                        BigText(text: _cartList[index].quantity.toString()),//products.inCartItems.toString()),
                                                        SizedBox(width: Dimensions.width10,),
                                                        GestureDetector(onTap: (){
                                                          cart.addItem(_cartList[index].product, 1);
                                                        },child: Icon(Icons.add, color:Colors.grey,)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                        }),
                    ),
                    ),
              ) : NoDataPage(text: "Your cart is empty!", directory: directory);
            }),
          ],
        ),

        bottomNavigationBar: GetBuilder<OrderController>(builder: (orderController){
          try{
            _phoneNumber.text = orderController.phoneNumber;
          }catch(e){
            print("cannot set value to phone number");
          }

          try{
            _postcode.text = orderController.postCode;
          }catch(e){
            print("cannot set value to postcode");
          }

          try{
            _city.text = orderController.city;
          }catch(e){
            print("cannot set value to city");
          }

          return GetBuilder<CartItemController>(builder: (cart){
            return Container(
              height: Dimensions.bottomHeightBar + Dimensions.height5*10,
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                ),
              ),

              child: cart.getItems.isNotEmpty ? Column(
                children: [
                  InkWell(
                    onTap: (()=> showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (_){
                          return Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*0.9,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(Dimensions.radius20),
                                            topRight: Radius.circular(Dimensions.radius20)
                                        )
                                    ),

                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: Dimensions.width20,
                                            right: Dimensions.width20,
                                            top: Dimensions.height20,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Order Info",style: robotoMedium,),
                                              AppTextField(textController: _phoneNumber, hintText: "Your Phone number", icon: Icons.map),

                                              SizedBox(height: Dimensions.height20,),
                                              AppTextField(textController: _city, hintText: "City", icon: Icons.person),

                                              SizedBox(height: Dimensions.height20,),
                                              AppTextField(textController: _postcode, hintText: "PostCode", icon: Icons.person),

                                              SizedBox(height: Dimensions.height20,),


                                              Text("Payment options",style: robotoMedium,),
                                              SizedBox(height: Dimensions.height15,),
                                              const PaymentOptionButton(
                                                icon: Icons.attach_money,
                                                title: "cash on delivery",
                                                subtitle: "you pay after getting the delivery",
                                                index: 0,
                                              ),
                                              SizedBox(height: Dimensions.height10,),
                                              const PaymentOptionButton(
                                                icon: Icons.paypal,
                                                title: "digital payment",
                                                subtitle: "safer and faster way of payment",
                                                index: 1,
                                              ),

                                              SizedBox(height: Dimensions.height20,),
                                              Text("Delivery options",style: robotoMedium,),
                                              const DeliveryOptions(
                                                  value: "Fast",
                                                  title: "Fast delivery",
                                                  amount: 12.00,
                                                  isFree: false
                                              ),
                                              const DeliveryOptions(
                                                  value: "Free",
                                                  title: "Free",
                                                  amount: 0,
                                                  isFree: true
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                    ).whenComplete(() {
                      orderController.setPhoneNumber(_phoneNumber.text.trim());
                      orderController.setCity(_city.text.trim());
                      orderController.setPostCode(_postcode.text.trim());
                    })),
                    child: const SizedBox(
                      width: double.maxFinite,
                      child: CommonTextButton(text: "Order details"),
                    ),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: Dimensions.width10,),
                            BigText(text: "${cart.totalAmount.toStringAsFixed(2)}лв."),
                            SizedBox(width: Dimensions.width10,),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () async {
                            if(Get.find<AuthController>().userLoggedIn()){
                              if(Get.find<UserController>().user!.address!.isEmpty){
                                Get.toNamed(RouteHelper.getAddAddress(directory));
                              }else{
                                {
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

                                    if(Get.find<OrderController>().paymentIndex == 0){
                                      await Get.find<OrderController>().placeOrder(true);
                                      Get.to(OrderSuccessPage(orderID: Get.find<OrderController>().order!.id!, status: Get.find<OrderController>().order!.status, directory: directory));
                                    }else{
                                      await Get.find<OrderController>().placeOrder(false);
                                      Get.to(PaypalPayment(
                                          onFinish: (){
                                            Get.find<OrderController>().updateOrder();

                                            Get.to(OrderSuccessPage(orderID: Get.find<OrderController>().order!.id!, status: Get.find<OrderController>().order!.status, directory: directory));
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
                                  }
                                }
                              }
                            }else{
                              Get.toNamed(RouteHelper.getSignIn(directory));
                            }
                          },
                          child: CommonTextButton(text: "Check out")
                      )],
                  ),
                ],
              ) : Container(),
            );});
        }),
      );
    });
  }
}
