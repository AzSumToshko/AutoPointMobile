class UserModel{
  String id;
  String firstName;
  String lastName;
  String email;
  String address;
  String password;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    // tuka moga da pisha predi da vurna
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      address: json['address'],
      password: json['password'],
    );
  }
}