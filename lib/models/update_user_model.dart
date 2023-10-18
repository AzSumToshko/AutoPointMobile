import 'package:auto_point_mobile/data/entities/user.dart';

class UpdateUserModel{
  int id;
  User user;

  UpdateUserModel({required this.id,required this.user});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
    };
  }
}