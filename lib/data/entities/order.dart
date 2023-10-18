class OrderEntity {
  late int? id;
  late int userId;
  late String productIds;
  late String productQuantities;
  late int productsCount;
  late String fullName;
  late String? companyName;
  late String phoneNumber;
  late String email;
  late String addressOne;
  late String? addressTwo;
  late String city;
  late String postcode;
  late String? details;
  late String paymentMethod;
  late String deliveryType;
  late num total;
  late String deliveryDate;
  late String status;

  OrderEntity(
      {this.id,
        required this.userId,
        required this.productIds,
        required this.productQuantities,
        required this.productsCount,
        required this.fullName,
        this.companyName,
        required this.phoneNumber,
        required this.email,
        required this.addressOne,
        this.addressTwo,
        required this.city,
        required this.postcode,
        this.details,
        required this.paymentMethod,
        required this.deliveryType,
        required this.total,
        required this.deliveryDate,
        required this.status});

  OrderEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    productIds = json['productIds'];
    productQuantities = json['productQuantities'];
    productsCount = json['productsCount'];
    fullName = json['fullName'];
    companyName = json['companyName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    addressOne = json['addressOne'];
    addressTwo = json['addressTwo'];
    city = json['city'];
    postcode = json['postcode'];
    details = json['details'];
    paymentMethod = json['paymentMethod'];
    deliveryType = json['deliveryType'];
    total = json['total'];
    deliveryDate = json['deliveryDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['productIds'] = this.productIds;
    data['productQuantities'] = this.productQuantities;
    data['productsCount'] = this.productsCount;
    data['fullName'] = this.fullName;
    data['companyName'] = this.companyName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['addressOne'] = this.addressOne;
    data['addressTwo'] = this.addressTwo;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['details'] = this.details;
    data['paymentMethod'] = this.paymentMethod;
    data['deliveryType'] = this.deliveryType;
    data['total'] = this.total;
    data['deliveryDate'] = this.deliveryDate;
    data['status'] = this.status;
    return data;
  }

  OrderEntity copy({
    int? id,
    int? userId,
    String? productIds,
    String? productQuantities,
    int? productsCount,
    String? fullName,
    String? companyName,
    String? phoneNumber,
    String? email,
    String? addressOne,
    String? addressTwo,
    String? city,
    String? postcode,
    String? details,
    String? paymentMethod,
    String? deliveryType,
    num? total,
    String? deliveryDate,
    String? status,
  }) =>
      OrderEntity(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        productIds: productIds ?? this.productIds,
        productQuantities: productQuantities ?? this.productQuantities,
        productsCount: productsCount ?? this.productsCount,
        fullName: fullName ?? this.fullName,
        companyName: companyName ?? this.companyName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        addressOne: addressOne ?? this.addressOne,
        addressTwo: addressTwo ?? this.addressTwo,
        city: city ?? this.city,
        postcode: postcode ?? this.postcode,
        details: details ?? this.details,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        deliveryType: deliveryType ?? this. deliveryType,
        total: total ?? this.total,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        status: status ?? this.status,
      );
}