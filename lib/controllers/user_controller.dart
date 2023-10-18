
import 'package:auto_point_mobile/data/entities/user.dart';
import 'package:auto_point_mobile/data/repository/user_repo.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  late final Response? response;

  User? _user;
  User? get user => _user;

  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  @override
  void onInit() async {
    super.onInit();
    _isLoading = true;
    update();

    if(userRepo.isUserLogged()){
      setUser(await userRepo.getLoggedUser());
      print("User : ${user?.firstName} ${user?.lastName} is logged in.");
    }

    _isLoading = false;
    update();
  }

  void removeUser(){
    _user = null;
    update();
  }

  void updateLoggedUser() async {
    User user = await userRepo.updateUser(_user!);
    setUser(user);
  }

  void setUser(User user){
    _user = user;
    update();
  }

  bool userLoggedIn(){
    return userRepo.isUserLogged();
  }

  void updateAddress(String newAddress) {
    if (_user != null) {
      // Remove backslashes and double quotes from the input string using regular expressions
      String cleanedAddress = newAddress.replaceAll(r'\\', '').replaceAll(r'"', '');
      _user!.setAddress(cleanedAddress);
      update();
    }
  }

  void updateFirstName(String newFirstName) {
    if (_user != null) {
      _user!.setFirstName(newFirstName);
      update();
    }
  }

  void updateLastName(String newLastName) {
    if (_user != null) {
      _user!.setLastName(newLastName);
      update();
    }
  }

  void updateEmail(String newEmail) {
    if (_user != null) {
      _user!.setEmail(newEmail);
      update();
    }
  }

  void updatePassword(String newPassword) {
    if (_user != null) {
      _user!.setPassword(newPassword);
      update();
    }
  }
}