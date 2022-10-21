import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_model_relation/env.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  bool isLoading = true;
  bool isError = false;
  bool isEmpty = false;
  String? errorMsg;

  List<Product> products = [];

  void _resetState() {
    isLoading = true;
    isError = false;
    isEmpty = false;
    products.clear();
    notifyListeners();
  }

  Future fetchProducts() async {
    try {
      _resetState();

      // Simulate real life fetching time.
      await Future.delayed(const Duration(seconds: 2));

      final url = Uri.http(kApiDomain, '$kApiBaseEndpoint/products');
      final response = await http.get(url, headers: kApiDefaultHeaders);
      inspect(response);

      if (response.statusCode == 200) {
        products = Product.listFromJSON(jsonDecode(response.body)['data']);
        inspect(products);
        if (products.isEmpty) {
          isEmpty = true;
        }
      } else {
        isError = true;
        isEmpty = false;
        errorMsg = "Something went wrong!!!";
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
