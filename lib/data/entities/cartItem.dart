class CartItem {
  late final String id;
  late final int productId;
  late final int userId;
  late final int productQuantity;

  CartItem({required this.id, required this.productId, required this.userId, required this.productQuantity});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    productId = json['productId'];
    userId = json['userId'];
    productQuantity = json['productQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['userId'] = this.userId;
    data['productQuantity'] = this.productQuantity;
    return data;
  }

  CartItem copy({
    String? id,
    int? productId,
    int? userId,
    int? productQuantity,
  }) =>
      CartItem(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        userId: userId ?? this.userId,
        productQuantity: productQuantity ?? this.productQuantity,
      );
}