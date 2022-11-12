import 'package:flutter_model_relation/fake_db/faker.dart';
import 'package:flutter_model_relation/models/product_detail.dart';
import 'package:uuid/uuid.dart';

import '../models/product.dart';

List<Product> fakeProducts = [];

List<Product> generateFakeProducts() {
  fakeProducts.clear();
  for (var i = 0; i < 5; i++) {
    fakeProducts.add(
      Product(
        id: const Uuid().v4(),
        name: faker.lorem.word(),
        productDetail: ProductDetail(
          price: faker.randomGenerator.decimal(scale: 999).toStringAsFixed(2),
        ),
      ),
    );
  }

  return fakeProducts;
}
