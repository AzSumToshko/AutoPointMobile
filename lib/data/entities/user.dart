class User {
  late final int? id;
  String? firstName;
  String? lastName;
  String? password;
  String? address;
  String? email;
  late final bool isAdmin;

  void setAddress(String newAddress) {
    address = newAddress;
  }

  void setFirstName(String newFirstName) {
    firstName = newFirstName;
  }

  void setLastName(String newLastName) {
    lastName = newLastName;
  }

  void setEmail(String newEmail) {
    email = newEmail;
  }

  void setPassword(String newPassword) {
    password = newPassword;
  }

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.password,
        this.address,
        this.email,
        required this.isAdmin});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    password = json['password'];
    address = json['address'] ?? "";
    email = json['email'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id ?? 0;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['password'] = password;
    data['address'] = address;
    data['email'] = email;
    data['isAdmin'] = isAdmin;
    return data;
  }

  User copy({
    int? id,
    String? firstName,
    String? lastName,
    String? password,
    String? address,
    String? email,
    bool? isAdmin,
  }) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        password: password ?? this.password,
        address: address ?? this.address,
        email: email ?? this.email,
        isAdmin: isAdmin ?? this.isAdmin,
      );
}