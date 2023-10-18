import 'package:auto_point_mobile/base/custom_app_bar.dart';
import 'package:auto_point_mobile/controllers/auth_controller.dart';
import 'package:auto_point_mobile/controllers/order_controller.dart';
import 'package:auto_point_mobile/pages/order/view_order.dart';
import 'package:auto_point_mobile/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/big_text.dart';

class OrderPage extends StatefulWidget {
  final directory;
  const OrderPage({Key? key,required this.directory}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{

  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState(){
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_isLoggedIn){
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isUserLogged = Get.find<AuthController>().userLoggedIn();
    return GetBuilder<OrderController>(builder: (orderController){

      if(isUserLogged){
        orderController.getOrdersForLoggedUser();
      }

      return Scaffold(
          appBar: CustomAppBar(title: "My orders",isBackButtonEnabled: false, directory: widget.directory,),
          body: isUserLogged?Column(
            children: [
              Container(
                width: Dimensions.screenWidth,
                child: TabBar(
                    indicatorColor: AppColors.mainColor,
                    labelColor: AppColors.mainColor,
                    unselectedLabelColor: Theme.of(context).disabledColor,
                    indicatorWeight: 3,
                    controller: _tabController,
                    tabs: const [
                      Tab(
                        text: "current",
                      ),
                      Tab(
                        text: "history",
                      )
                    ]
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ViewOrder(isPending: true, directory: widget.directory,),
                    ViewOrder(isPending: false, directory: widget.directory,),
                  ],
                ),
              ),

              SizedBox(height: Dimensions.height45,)
            ],
          ):Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height20 * 15,
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/image/signInImage.png",
                      ),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getSignIn(widget.directory));
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height20 * 5,
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor
                    ),
                    child: Center(child: BigText(text: "Sign In", color: Colors.white,size: Dimensions.font20,)),

                  ),
                ),
              ],
            ),
          ),
      );
    });
  }
}
