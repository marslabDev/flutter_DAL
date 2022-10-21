import 'package:flutter_model_relation/fake_db/faker.dart';
import 'package:flutter_model_relation/models/product_detail.dart';
import 'package:uuid/uuid.dart';

import '../models/product.dart';

List<Product> productTable = [
  Product(
    id: const Uuid().v4(),
    name: faker.lorem.word(),
    productDetail: ProductDetail(
      price: '${faker.currency.random}',
    ),
  ),

  Product(
    id: const Uuid().v4(),
    name: faker.lorem.word(),
    productDetail: ProductDetail(
      price: '${faker.currency.random}',
    ),
  ),

  Product(
    id: const Uuid().v4(),
    name: faker.lorem.word(),
    productDetail: ProductDetail(
      price: '${faker.currency.random}',
    ),
  ),

  Product(
    id: const Uuid().v4(),
    name: faker.lorem.word(),
    productDetail: ProductDetail(
      price: '${faker.currency.random}',
    ),
  ),

  Product(
    id: const Uuid().v4(),
    name: faker.lorem.word(),
    productDetail: ProductDetail(
      price: '${faker.currency.random}',
    ),
  ),
];
