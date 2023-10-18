import 'package:auto_point_mobile/data/entities/order.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class OrderRepo extends GetxService{
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response> getOrderList() async{
    return await apiClient.getData(AppConstants.GET_ORDER_ALL);
  }

  Future<Map<String,dynamic>> placeOrder (OrderEntity order) async {
    return apiClient.postOrder(order);
  }

  Future<http.Response> deleteOrder(int id){
    return apiClient.deleteOrder(id);
  }

  Future<OrderEntity> getOrder(int id) async {
    try {
      return await apiClient.getOrder(id);
    } catch (e) {
      throw('Error: $e');
    }
  }

  Future<http.Response> updateOrder(int id, OrderEntity order) async {
    try {
      return await apiClient.putOrder(id, order);
    } catch (e) {
      throw('Error: $e');
    }
  }

  Future<List<OrderEntity>> getOrdersForUser(int userID) async {
    try{
      return await apiClient.getOrdersForUser(userID);
    }catch(e){
      throw Exception('Failed to fetch orders');
    }
  }
}