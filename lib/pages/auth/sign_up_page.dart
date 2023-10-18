import 'package:auto_point_mobile/base/custom_loader.dart';
import 'package:auto_point_mobile/base/show_custom_snackbar.dart';
import 'package:auto_point_mobile/controllers/auth_controller.dart';
import 'package:auto_point_mobile/models/sign_up_body_model.dart';
import 'package:auto_point_mobile/routes/route_helper.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/widgets/app_text_field.dart';
import 'package:auto_point_mobile/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';

class SignUpPage extends StatelessWidget {
  final directory;
  const SignUpPage({Key? key, required this.directory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var emailController = TextEditingController();
    var addressController = TextEditingController();
    var passwordController = TextEditingController();

    var signUpImages = [
      "i.png",
      "f.png",
      "g.png",
    ];

    final latitude = 37.7749; // Replace with the latitude of the location you want to open
    final longitude = -122.4194; // Replace with the longitude of the location you want to open

    var urls = [
      'https://www.instagram.com/natgeo',
      'fb://profile/bushido.club.plovdiv',
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    ];

    void _registration(AuthController auth){

      String firstName = firstNameController.text.trim();
      String lastName = lastNameController.text.trim();
      String email = emailController.text.trim();
      String address = addressController.text.trim();
      String password = passwordController.text.trim();

      if(firstName.isEmpty){
        showCustomSnackBar("Type in your first name", title: "Name");
      }else if(lastName.isEmpty){
        showCustomSnackBar("Type in your last name", title: "Name");
      }else if(email.isEmpty){
        showCustomSnackBar("Type in your email", title: "Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Email");
      }else if(address.isEmpty){
        showCustomSnackBar("Type in your address", title: "Address");
      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      }else if(password.length <8){
        showCustomSnackBar("Password can not be less than eight characters", title: "Password");
      }else{
        SignUpBody registerModel = SignUpBody(
                                          firstName: firstName,
                                          lastName: lastName,
                                          email: email,
                                          address: address,
                                          password: password);

        auth.registration(registerModel).then((status){
          if(status.isSuccess){
            print("Success registration");
            Get.toNamed(RouteHelper.getSignIn(directory));
          }else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (auth){
        return !auth.isLoading ? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [

              SizedBox(height: Dimensions.screenHeight * 0.03,),

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

              AppTextField(textController: firstNameController, hintText: "First Name", icon: Icons.drive_file_rename_outline_rounded),

              SizedBox(height: Dimensions.height20,),

              AppTextField(textController: lastNameController, hintText: "Lsat Name", icon: Icons.drive_file_rename_outline_rounded),

              SizedBox(height: Dimensions.height20,),

              AppTextField(textController: emailController, hintText: "Email", icon: Icons.email),

              SizedBox(height: Dimensions.height20,),

              AppTextField(textController: addressController, hintText: "Address", icon: Icons.location_on),

              SizedBox(height: Dimensions.height20,),

              AppTextField(textController: passwordController, hintText: "Password", icon: Icons.password, isObscure: true),

              SizedBox(height: Dimensions.height20,),

              GestureDetector(
                onTap: (){
                  _registration(auth);
                },
                child: Container(
                  width: Dimensions.screenWidth / 2,
                  height:  Dimensions.screenHeight / 13,
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),

                  child: Center(child: BigText(text: "Sign up", size: Dimensions.font20 + Dimensions.font20/2, color: Colors.white,)),

                ),
              ),

              SizedBox(height: Dimensions.height10,),

              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=> Get.toNamed(RouteHelper.getSignIn(directory)),
                    text: "Have an account already?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20,
                    )
                ),
              ),

              SizedBox(height: Dimensions.screenHeight * 0.05,),
            ],
          ),
        ) : const CustomLoader();
      }),
    );
  }
}
