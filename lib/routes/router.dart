import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_model_relation/screens/home/home_screen.dart';
import 'package:flutter_model_relation/screens/product/add_product_screen.dart';
import 'package:flutter_model_relation/screens/product/product_screen.dart';

class RouteList {
  static const String product = '/product';
  static const String addProduct = '/add-product';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    inspect(args);

    switch (settings.name) {
      case RouteList.product:
        // final productScreenArgs = args as ProductScreenArgs;

        // return MaterialPageRoute(
        //   builder: (_) => ProductScreen(
        //     title: productScreenArgs.title,
        //     product: productScreenArgs.product,
        //   ),
        // );
      case RouteList.addProduct:
        return MaterialPageRoute(
          builder: (_) => const AddProductScreen(
            title: 'Add Product',
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(
            title: 'E-Comm App',
          ),
        );
    }
  }
}
