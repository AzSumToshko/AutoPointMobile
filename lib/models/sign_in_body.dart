class SignInBody{
  String email;
  String password;

  SignInBody({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map();
    data ["email"] = this.email;
    data ["password"] = this.password;
    return data;
  }
}