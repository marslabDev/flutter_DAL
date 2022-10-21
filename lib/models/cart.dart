import 'product.dart';

class Cart {
  // One to many relationship
  List<Product> products = [];

  Cart({
    required this.products,
  });
}
