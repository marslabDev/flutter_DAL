import 'product.dart';

class Tag {
  String? id;
  String name = '';

  List<Product>? products;

  Tag({
    this.id,
    required this.name,
    this.products,
  });

  factory Tag.fromJSON(Map<String, dynamic> json) {
    return Tag(
      id: json['id']?.toString(),
      name: json['name'],
      products: json['products'] != null
          ? Product.listFromJSON(json['products'])
          : null,
    );
  }

  static List<Tag> listFromJSON(dynamic list) {
    return List<Tag>.from(
      list.map((json) {
        return Tag.fromJSON(json);
      }),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
    };
  }
}
