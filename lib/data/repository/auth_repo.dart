import 'package:auto_point_mobile/data/api/api_client.dart';
import 'package:auto_point_mobile/models/sign_up_body_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/sign_in_body.dart';
import '../../utils/constants.dart';
import '../entities/user.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpBody signUpBody) async {
    User user = User(
        firstName: signUpBody.firstName,
        lastName: signUpBody.lastName,
        password: signUpBody.password,
        address: signUpBody.address,
        email: signUpBody.email,
        isAdmin: false);

    return await apiClient.postDate(AppConstants.POST_USER_CREATE, user.toJson());
  }

  Future<Response> login(SignInBody signInBody) async {

    return await apiClient.getDataForLogin(AppConstants.GET_USER_BY_EMAIL_AND_PASSWORD, {"email" : signInBody.email , "password" : signInBody.password});
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.EMAIL);
  }

  void logout(){
    sharedPreferences.remove(AppConstants.EMAIL);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.TOKEN);
    apiClient.token = '';
    apiClient.updateHeader('');
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.EMAIL)??"None";
  }

  saveUserToken(String email) async {
    return await sharedPreferences.setString(AppConstants.EMAIL, email);
  }

  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try{
      await sharedPreferences.setString(AppConstants.EMAIL, email);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }
}