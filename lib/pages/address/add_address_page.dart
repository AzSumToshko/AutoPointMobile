import 'package:auto_point_mobile/base/custom_app_bar.dart';
import 'package:auto_point_mobile/controllers/auth_controller.dart';
import 'package:auto_point_mobile/controllers/location_controller.dart';
import 'package:auto_point_mobile/controllers/user_controller.dart';
import 'package:auto_point_mobile/routes/route_helper.dart';
import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/widgets/app_text_field.dart';
import 'package:auto_point_mobile/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../utils/dimensions.dart';

class AddAddressPage extends StatefulWidget {
  final directory;
  const AddAddressPage({Key? key, required this.directory}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState(directory: directory);
}

class _AddAddressPageState extends State<AddAddressPage> {
  final directory;
  _AddAddressPageState({required this.directory});
  
  TextEditingController _addressController = TextEditingController();

  late bool _isLogged;

  late LatLng _initialPosition = LatLng(42.1234443, 24.6886565);
  
  @override
  void initState(){
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Address", directory: directory,),
      body: GetBuilder<UserController>(builder: (userController){
        return SingleChildScrollView(
          child: GetBuilder<LocationController>(builder: (locationController){
            if(userController.user!.address!.isNotEmpty && _addressController.text.isEmpty){
              _addressController.text = userController.user!.address!;
            }
            if(locationController.selectedAddress.isNotEmpty){
              if(locationController.setSelectedAddress){
                _addressController.text = locationController.selectedAddress;
                locationController.setSelectedAddress = false;
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //This is the map
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5,right: 5,top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2,
                        color: AppColors.mainColor
                      )
                  ),
                  child: Stack(
                    children: [
                      FlutterMap(
                        options: MapOptions(
                          center: LatLng(_initialPosition.latitude, _initialPosition.longitude),
                          zoom: 9.2,
                          onPositionChanged: (MapPosition position, bool hasGesture) {
                            //_initialPosition.longitude = position.center!.longitude;
                            //_initialPosition.latitude = position.center!.latitude;
                            //Get.find<LocationController>().update();
                          },
                          onTap: (tapPosition,latLng){
                            locationController.setAddress(latLng.latitude, latLng.longitude);
                            Get.toNamed(RouteHelper.getPickAddress(directory));
                          }
                        ),
                        nonRotatedChildren: [
                          AttributionWidget.defaultWidget(
                            source: 'OpenStreetMap contributors',
                            onSourceTapped: null,
                          ),
                        ],
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                        ],
                      ),


                    ],
                  ),
                ),

                SizedBox(height: Dimensions.height45,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Delivery Address"),
                ),

                SizedBox(height: Dimensions.height20,),
                AppTextField(textController: _addressController, hintText: "Your Address", icon: Icons.map,maxLines: true,),
              ],
            );
          }),
        );
      }),

      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController){
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
                  userController.updateAddress(_addressController.text);

                  userController.updateLoggedUser();

                  locationController.clean();
                  Get.toNamed(RouteHelper.getInitial(directory));
                },
                child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),

                    child: BigText(
                      text: "Save address", color: Colors.white, size: 26,)
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
