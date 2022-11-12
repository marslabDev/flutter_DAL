import 'category.dart';
import 'product_detail.dart';
import 'tag.dart';

class Product {
  String? id;
  String name = '';

  // One to one relationship
  ProductDetail? productDetail;

  // One to many relationship
  List<Category>? categories;
  List<Tag>? tags;

  Product({
    this.id,
    required this.name,
    required this.productDetail,
    this.categories,
    this.tags,
  });

  factory Product.fromJSON(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString(),
      name: json['name'],
      productDetail: json['product_product_details'] != null
          ? ProductDetail.fromJSON(json['product_product_details'])
          : null,
      categories: json['categories'] != null
          ? Category.listfromJSON(json['categories'])
          : null,
      tags: json['tags'] != null ? Tag.listFromJSON(json['tags']) : null,
    );
  }

  static List<Product> listFromJSON(dynamic list) {
    return List<Product>.from(
      list.map((json) {
        return Product.fromJSON(json);
      }),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      // 'product_detail': productDetail?.toJSON(),
      // 'categories': categories?.map((element) {
      //   return element.toJSON();
      // }),
      // 'tags': tags?.map((element) {
      //   return element.toJSON();
      // }),
    };
  }
}
