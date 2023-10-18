import 'package:auto_point_mobile/base/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';
import 'account_page.dart';

class EditProfile extends StatefulWidget {
  final directory;
  const EditProfile({Key? key,required this.directory}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile", directory: widget.directory),
      body: GetBuilder<UserController>(builder: (userController){
        if(userController.userLoggedIn()){
          _firstName.text = userController.user!.firstName!;
          _lastName.text = userController.user!.lastName!;
          _email.text = userController.user!.email!;
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.height20,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width20),
                child: BigText(text: "First Name"),
              ),

              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: _firstName, hintText: "Your first name", icon: Icons.map),

              SizedBox(height: Dimensions.height45,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width20),
                child: BigText(text: "Last Name"),
              ),

              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: _lastName, hintText: "Your last name", icon: Icons.map),

              SizedBox(height: Dimensions.height45,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width20),
                child: BigText(text: "Email"),
              ),

              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: _email, hintText: "Your email", icon: Icons.map),

              SizedBox(height: Dimensions.height45,),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width20),
                child: BigText(text: "Password"),
              ),

              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: _password, hintText: "Your password", icon: Icons.map,isObscure: true),
            ],
          ),
        );
      }),

      bottomNavigationBar: GetBuilder<UserController>(builder: (userController){
        return Container(
          height: Dimensions.height20 * 7,
          padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20*2),
              topRight: Radius.circular(Dimensions.radius20*2),
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<UserController>(builder: (userController) {
                return GestureDetector(
                  onTap: () {
                    if(_firstName.text.isEmpty){

                    }else if(_firstName.text.length < 4){

                    }else if(_lastName.text.isEmpty){

                    }else if(_lastName.text.length < 4){

                    }else if(_email.text.isEmpty){

                    }else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_email.text)){

                    }else if(_password.text.isNotEmpty && _password.text.length < 8){

                    }else{
                      userController.updateFirstName(_firstName.text);
                      userController.updateLastName(_lastName.text);
                      userController.updateEmail(_email.text);
                      if(_password.text.isNotEmpty){
                        userController.updatePassword(_password.text);
                      }

                      userController.updateLoggedUser();

                      Get.to(AccountPage(directory: widget.directory,));
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),

                      child: BigText(
                        text: "Save your information", color: Colors.white, size: 26,)
                  ),
                );
              })
            ],
          ),
        );
      }),
    );
  }
}
