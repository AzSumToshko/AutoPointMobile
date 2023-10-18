import 'package:auto_point_mobile/routes/route_helper.dart';
import 'package:auto_point_mobile/widgets/big_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

import '../../controllers/location_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class PickAddressMap extends StatelessWidget {
  final directory;
  PickAddressMap({Key? key, required this.directory}) : super(key: key);

  late LatLng _initialPosition = LatLng(
      Get.find<LocationController>().getAddressToLatLng().latitude,
      Get.find<LocationController>().getAddressToLatLng().longitude);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(width: double.maxFinite,
              child: Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      center: LatLng(
                        locationController.getAddressToLatLng().latitude,
                        locationController.getAddressToLatLng().longitude,
                      ),
                      zoom: 9.2,
                      onPositionChanged: (MapPosition position, bool hasGesture) {
                        locationController.setLoading(true);
                        locationController.setAddress(position.center!.latitude, position.center!.longitude);
                        locationController.debounceSubject.add(null); // Add event to debounceSubject
                      },
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

                      MarkerLayer(
                        markers: [
                          Marker(
                              width: 65.0,
                              height: 65.0,
                              point: LatLng.fromJson(locationController.getAddress),
                              builder: (context) => Container(
                                child: const Image(image: AssetImage("assets/image/fav.png")),
                              ))
                        ],
                      )
                    ],
                  ),

                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,

                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.map,size: 25, color: Colors.white,),
                          Expanded(
                            child: Text(
                              locationController.getAddressName() ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),

                  Positioned(
                    bottom: Dimensions.height40 * 1.5,
                    left: Dimensions.width40,
                    right: Dimensions.width40,
                    child: GestureDetector(
                      onTap: (){
                        if(!locationController.isLoading){
                          locationController.setFinalAddress();
                          Get.toNamed(RouteHelper.getAddAddress(directory));
                        }
                      },
                      child: Container(
                        height: Dimensions.height5 * 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Center(
                          child: BigText(text: "Pick Address",color: Colors.white,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    );
  }
}
