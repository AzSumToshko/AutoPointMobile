import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';
import '../entities/user.dart';

class UserRepo extends GetxService{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  UserRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getUserList() async{
    return await apiClient.getData(AppConstants.GET_USER_ALL);
  }

  bool isUserLogged(){
    return sharedPreferences.containsKey(AppConstants.EMAIL);
  }

  Future<User> getLoggedUser() async {
    User user;

    String email = sharedPreferences.getString(AppConstants.EMAIL)!;

    Response response = await apiClient.getDataFromEmail(AppConstants.GET_USER_BY_EMAIL, {"email" : email});

    if(response.statusCode == 200 || response.statusCode == 201){
      return user = User.fromJson(response.body);
    }else{
      throw Exception(response.statusCode!);
    }
  }

  Future<User> updateUser(User user) async {
    await apiClient.updateUser(user.id!, user);

    return await getLoggedUser();
  }
}