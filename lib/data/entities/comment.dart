class Comment {
  late final String id;
  late final int productId;
  late final String fullName;
  late final String message;

  Comment({required this.id, required this.productId, required this.fullName, required this.message});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    productId = json['productId'];
    fullName = json['fullName'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['fullName'] = this.fullName;
    data['message'] = this.message;
    return data;
  }

  Comment copy({
    String? id,
    int? productId,
    String? fullName,
    String? message,
  }) =>
      Comment(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        fullName: fullName ?? this.fullName,
        message: message ?? this.message,
      );
}