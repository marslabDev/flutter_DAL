class ProductDetail {
  String price = '';
  String? description;

  ProductDetail({
    required this.price,
    this.description,
  });

  factory ProductDetail.fromJSON(Map<String, dynamic> json) {
    return ProductDetail(
      price: json['price'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'price': price,
      'description': description,
    };
  }
}
