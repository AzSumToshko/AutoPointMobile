import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final bool isObscure;
  bool maxLines;

  AppTextField({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    this.maxLines = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: Offset(1, 5),
              color: Colors.grey.withOpacity(0.2),
            )
          ]
      ),
      child: TextField(
        maxLines: maxLines ? 3 : 1,
        onSubmitted: (String newText){
          textController.text = newText;
        },
        obscureText: isObscure,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,

          prefixIcon: Icon(icon, color: AppColors.mainColor,),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
                width: 1.0,
                color: Colors.white
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            borderSide: BorderSide(
                width: 1.0,
                color: Colors.white
            ),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius15),
          ),

        ),

      ),
    );
  }
}
