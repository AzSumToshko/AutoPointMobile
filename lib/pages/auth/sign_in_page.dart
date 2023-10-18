import 'package:auto_point_mobile/base/custom_loader.dart';
import 'package:auto_point_mobile/models/sign_in_body.dart';
import 'package:auto_point_mobile/routes/route_helper.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/widgets/app_text_field.dart';
import 'package:auto_point_mobile/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../data/entities/user.dart';
import '../../utils/dimensions.dart';

class SignInPage extends StatelessWidget {
  final directory;
  const SignInPage({Key? key, required this.directory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController auth) async {

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(email.isEmpty){
        showCustomSnackBar("Type in your email", title: "Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Email");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      }else if(password.length <8){
        showCustomSnackBar("Password can not be less than eight characters", title: "Password");
      }else{
        SignInBody loginModel = SignInBody(
            email: email,
            password: password);

        try{
          User user = await auth.login(loginModel);
          print("${user.firstName} successfully logged");

          Get.toNamed(RouteHelper.getInitial(directory));
        }catch(e){
          showCustomSnackBar("No user found with such credentials!", title: "User not found");
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (auth){
        return !auth.isLoading ? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [

              SizedBox(height: Dimensions.screenHeight * 0.08,),

              Container(
                height: Dimensions.screenHeight * 0.20,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.radius20 *2.5,
                    backgroundImage: AssetImage("assets/image/fav.png"),
                  ),
                ),
              ),

              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20 * 3 + Dimensions.font20/2,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    Text(
                      "Sign into your account",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: Colors.grey[500]
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(height: Dimensions.height20,),

              AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),

              SizedBox(height: Dimensions.height20,),

              AppTextField(textController: passwordController, hintText: "Password", icon: Icons.password, isObscure: true),

              SizedBox(height: Dimensions.height20,),

              Row(
                children: [
                  Expanded(child: Container()),

                  RichText(
                    text: TextSpan(
                        text: "Sign into your account",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        )
                    ),
                  ),

                  SizedBox(width: Dimensions.width20,)
                ],
              ),

              SizedBox(height: Dimensions.height40,),

              GestureDetector(
                onTap: (){
                  _login(auth);
                },
                child: Container(
                  width: Dimensions.screenWidth / 2,
                  height:  Dimensions.screenHeight / 13,
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),

                  child: Center(child: BigText(text: "Sign in", size: Dimensions.font20 + Dimensions.font20/2, color: Colors.white,)),

                ),
              ),

              SizedBox(height: Dimensions.screenHeight * 0.06,),

              RichText(

                text: TextSpan(
                  text: "Don\'t have an account?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                  children: [

                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.toNamed(RouteHelper.getSignUp(directory)),
                      text: " Create",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: Dimensions.font20,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ) : const CustomLoader();
      }),
    );
  }
}
