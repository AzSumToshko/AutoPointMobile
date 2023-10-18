import 'dart:typed_data';

import 'package:auto_point_mobile/utils/constants.dart';
import 'package:get/get.dart';
import '../api/api_client.dart';

class ProductRepo extends GetxService{
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});

  Future<Response> getProductList() async{
    return await apiClient.getData(AppConstants.GET_PRODUCT_ALL);
  }

  Future<Uint8List> postRemoveBackground(Uint8List image) async{
    return await apiClient.removeBackground(image);
  }
}