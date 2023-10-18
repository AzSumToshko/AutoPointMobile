class Product {
  late final String id;
  late final String name;
  late final num price;
  late final String typeOfProduct;
  late final String description;
  late final String image;

  Product(
      {required this.id,
        required this.name,
        required this.price,
        required this.typeOfProduct,
        required this.description,
        required this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    price = json['price'];
    typeOfProduct = json['typeOfProduct'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['typeOfProduct'] = this.typeOfProduct;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }

  Product copy({
    String? id,
    String? name,
    num? price,
    String? typeOfProduct,
    String? description,
    String? image,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        typeOfProduct: typeOfProduct ?? this.typeOfProduct,
        description: description ?? this.description,
        image: image ?? this.image,
      );
}