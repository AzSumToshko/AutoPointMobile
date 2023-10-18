import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final directory;
  final String title;
  final bool isBackButtonEnabled;
  final List<Widget>? actions;
  final Function? onPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.isBackButtonEnabled = true,
    this.onPressed,
    required this.directory,
    this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mainColor,
      actions: actions,
      title: BigText(text: title, color: Colors.white,),
      centerTitle: true,
      elevation: 0,
      leading: isBackButtonEnabled
          ?IconButton(
          onPressed: ()=> onPressed != null
              ?onPressed!()
              :Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new))

          :SizedBox(),

    );
  }

  @override
  Size get preferredSize => Size(Dimensions.screenWidth, Dimensions.height5*11);
}
