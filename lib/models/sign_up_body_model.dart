class SignUpBody{
  String firstName;
  String lastName;
  String email;
  String address;
  String password;

  SignUpBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.password,
  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map();
    data ["firstName"] = this.firstName;
    data ["lastName"] = this.lastName;
    data ["email"] = this.email;
    data ["address"] = this.address;
    data ["password"] = this.password;
    return data;
  }
}