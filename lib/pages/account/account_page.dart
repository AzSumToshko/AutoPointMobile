import 'package:auto_point_mobile/base/custom_app_bar.dart';
import 'package:auto_point_mobile/base/custom_loader.dart';
import 'package:auto_point_mobile/controllers/auth_controller.dart';
import 'package:auto_point_mobile/controllers/cartItem_controller.dart';
import 'package:auto_point_mobile/controllers/user_controller.dart';
import 'package:auto_point_mobile/pages/account/edit_profile.dart';
import 'package:auto_point_mobile/routes/route_helper.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/utils/dimensions.dart';
import 'package:auto_point_mobile/widgets/account_widget.dart';
import 'package:auto_point_mobile/widgets/app_icon.dart';
import 'package:auto_point_mobile/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final directory;
  const AccountPage({Key? key, required this.directory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (user){
      return Scaffold(
        appBar: CustomAppBar(title: "Profile",isBackButtonEnabled: false, directory: directory,),

        body: user.userLoggedIn()? (
            !user.isLoading?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [

              //profile icon
              AppIcon(
                icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height45 + Dimensions.height30,
                size: Dimensions.height15 *10,),

              SizedBox(height: Dimensions.height30,),

              Expanded(

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //name
                      AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10 * 2.5,
                            size: Dimensions.height10 * 5,),

                          bigText: BigText(
                              text: "${user.user?.firstName} ${user.user?.lastName}")),


                      SizedBox(height: Dimensions.height20,),

                      //email
                      AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.email,
                            backgroundColor: Colors.yellow,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10 * 2.5,
                            size: Dimensions.height10 * 5,),

                          bigText: BigText(
                              text: user.user?.email ?? "none")),

                      SizedBox(height: Dimensions.height20,),

                      //address
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteHelper.getAddAddress(directory));
                        },
                        child: AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.location_on,
                              backgroundColor: Colors.yellow,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 2.5,
                              size: Dimensions.height10 * 5,),

                            bigText: BigText(
                              maxLines: 2,
                                text: user.user?.address ?? "none",
                                overFlow: TextOverflow.ellipsis,)),
                      ),

                      SizedBox(height: Dimensions.height20,),

                      //address
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.to(EditProfile(directory: directory,));
                          }
                        },
                        child: AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.edit,
                              backgroundColor: Colors.red,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 2.5,
                              size: Dimensions.height10 * 5,),

                            bigText: BigText(
                                text: "Edit Profile")),
                      ),

                      SizedBox(height: Dimensions.height20,),

                      //address
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.find<AuthController>().logoutUser();
                            Get.find<CartItemController>().clear();
                            Get.find<CartItemController>().clearCartHistory();
                            Get.toNamed(RouteHelper.getSignIn(directory));
                            Get.find<UserController>().removeUser();
                          }
                        },
                        child: AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.message,
                              backgroundColor: Colors.red,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 2.5,
                              size: Dimensions.height10 * 5,),

                            bigText: BigText(
                                text: "Logout")),
                      ),

                      SizedBox(height: Dimensions.height45,)
                    ],
                  ),
                ),
              )
            ],
          ),
        )

            :CustomLoader())

            :Center(
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
                      Get.toNamed(RouteHelper.getSignIn(directory));
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
