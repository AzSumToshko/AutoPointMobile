import 'package:auto_point_mobile/controllers/auth_controller.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("its loading ${Get.find<AuthController>().isLoading}");
    return Center(
      child: Container(
        height: Dimensions.height20 * 5,
        width: Dimensions.height20 * 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20 * 2.5),
          color: AppColors.mainColor
        ),
        alignment: Alignment.center,

        child: const CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
