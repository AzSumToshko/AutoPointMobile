import 'package:auto_point_mobile/controllers/user_controller.dart';
import 'package:auto_point_mobile/data/repository/auth_repo.dart';
import 'package:auto_point_mobile/models/response_model.dart';
import 'package:get/get.dart';

import '../data/entities/user.dart';
import '../models/sign_in_body.dart';
import '../models/sign_up_body_model.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody registerModel) async {
    _isLoading = true;
    update();

    Response response = await authRepo.registration(registerModel);
    late ResponseModel responseModel;

    if(response.statusCode == 200 || response.statusCode == 201){
      authRepo.saveUserToken(registerModel.email);
      responseModel = ResponseModel(true, response.body["token"] ?? "DbToken");
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<User> login(SignInBody loginModel) async {
    _isLoading = true;
    User user;
    update();

    Response response = await authRepo.login(loginModel);

    if(response.statusCode == 200 || response.statusCode == 201){
      user = User.fromJson(response.body);
      Get.find<UserController>().setUser(user);

      authRepo.saveUserToken(user.email!);

      _isLoading = false;
      update();

      return user;
    }else{
      _isLoading = false;
      update();
      throw Exception(response.statusCode!);
    }
  }

  void logoutUser(){
    authRepo.logout();
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  void saveUserEmailAndPassword(String email, String password) {
    authRepo.saveUserEmailAndPassword(email, password);
  }
}