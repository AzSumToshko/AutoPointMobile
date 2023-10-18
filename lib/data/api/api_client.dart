import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_point_mobile/data/entities/order.dart';
import 'package:http/http.dart' as http;
import 'package:auto_point_mobile/utils/constants.dart';
import 'package:get/get.dart' as g;
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../entities/user.dart';


class ApiClient extends g.GetConnect implements g.GetxService{
  String? token;
  final String appBaseUrl;

  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){
    //the base url to the server
    baseUrl = appBaseUrl;

    //the duration of the application to try access the server
    timeout = Duration(seconds: 30);

    token = AppConstants.TOKEN ?? "";

    _mainHeaders={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $token',
    };
  }

  void updateHeader(String token) {
    _mainHeaders={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization':'Bearer $token',
    };
  }

  Future<g.Response> getData(String uri,) async{
    try{
      g.Response response = await get(uri);
      return response;
    }catch(e){
      return g.Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<g.Response> getDataForLogin(String uri, dynamic body) async{
    try{
      g.Response response = await get("$uri${body["email"]}&${body["password"]}");
      return response;
    }catch(e){
      return g.Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<g.Response> getDataFromEmail(String uri, dynamic body) async{
    try{
      g.Response response = await get("$uri${body["email"]}");
      return response;
    }catch(e){
      return g.Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<g.Response> postDate(String uri, dynamic body) async{
    try{
      g.Response response = await post(uri, body, headers: _mainHeaders);
      return response;
    }catch(e){
      print(e.toString());
      return g.Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<http.Response> deleteOrder(int id) async {
    final String apiUrl = '${AppConstants.BASE_URL}/api/Order/$id'; // Update with your API endpoint URL

    try {
      final response = await http.delete(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 204) {
        return response;
      } else {
        throw Exception('Failed to delete order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete order. Exception: $e');
    }
  }

  Future<Map<String,dynamic>> postOrder(OrderEntity order) async {
    const String apiUrl = '${AppConstants.BASE_URL}/api/Order';

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(order.toJson()));

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to post order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to post order. Exception: $e');
    }
  }

  Future<void> updateUser(int id, User user) async {
    final String apiUrl = '$baseUrl${AppConstants.PUT_USER_UPDATE}$id';
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      // Convert User object to JSON
      final userJson = jsonEncode(user.toJson());

      // Make PUT request to update user
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: headers,
        body: userJson,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Successful update, handle response if needed
        print('User updated successfully');
      } else if (response.statusCode == 400) {
        // Bad request, handle error if needed
        print('Bad request: ${response.body}');
      } else if (response.statusCode == 404) {
        // User not found, handle error if needed
        print('User not found');
      } else {
        // Other status codes, handle error if needed
        print('Error: ${response.body}');
      }
    } catch (e) {
      // Exception occurred, handle error if needed
      print('Error: $e');
    }
  }

  Future<Uint8List> compressImage(Uint8List imageFile, int quality) async {
    // compress the image
    final compressedImage = await FlutterImageCompress.compressWithList(
      imageFile,
      quality: quality,
    );

    // check if the compressed image is smaller than the original
    if (compressedImage.length >= imageFile.length) {
      // if not, return the original image
      return imageFile;
    } else {
      // otherwise, return the compressed image
      return compressedImage;
    }
  }

  Future<http.Response> getLocation(double lat , double lon) async {
    String apiKey = "534846abf0mshb184e5d747fecebp11d6aajsn7d9451e74bc2";
    String apiUrl = "https://forward-reverse-geocoding.p.rapidapi.com/v1/";

    const String endpoint = "reverse";
    final String query = "lat=${lat}&lon=${lon}";

    final response = await http.get(Uri.parse(apiUrl + endpoint + "?" + query), headers: {
      "X-RapidAPI-Key": apiKey,
      "X-RapidAPI-Host": "forward-reverse-geocoding.p.rapidapi.com",
    });

    return response;
  }

  Future<OrderEntity> getOrder(int id) async {
    final String apiUrl = '${AppConstants.BASE_URL}/api/Order/$id'; // Update with your API endpoint URL

    try {
      final response = await http.get(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return OrderEntity.fromJson(jsonData); // Update with your Order model deserialization logic
      } else {
        throw Exception('Failed to get order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get order. Exception: $e');
    }
  }

  Future<http.Response> putOrder(int id, OrderEntity order) async {
    final String apiUrl = '${AppConstants.BASE_URL}/api/Order/$id'; // Update with your API endpoint URL

    try {
      final response = await http.put(Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(order.toJson()));

      if (response.statusCode == 204) {
        return response;
      } else {
        throw Exception('Failed to update order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update order. Exception: $e');
    }
  }

  Future<Uint8List> removeBackground(Uint8List imageFile) async {
    var request = http.MultipartRequest(
      "POST", Uri.parse("https://api.remove.bg/v1.0/removebg")
    );
    request.files
    .add(await http.MultipartFile.fromBytes("image_file", await compressImage(imageFile, 90)));
    request.headers.addAll({'X-Api-Key': 'H6ktkoEB8i3RpuoEF5swJqx4'});
    final response = await request.send();
    if(response.statusCode == 200){
      http.Response imgRes = await http.Response.fromStream(response);
      return imgRes.bodyBytes;
    }else{
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }

  Future<List<OrderEntity>> getOrdersForUser(int userID) async {
    final url = '${AppConstants.BASE_URL}${AppConstants.GET_ORDERS_BY_USER_ID}$userID';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<OrderEntity> orders = [];
      for (var item in jsonData) {
        orders.add(OrderEntity.fromJson(item));
      }
      return orders;
    } else {
      throw Exception('Failed to fetch orders');
    }
  }
}