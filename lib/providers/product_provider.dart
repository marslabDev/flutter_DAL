import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_model_relation/fake_db/product_table.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  bool isLoading = true;
  bool isError = false;
  bool isEmpty = false;
  double progress = 0.0;
  String? errorMsg;

  List<Product> products = [];

  void _resetState() {
    isLoading = true;
    isError = false;
    isEmpty = false;
    progress = 0.0;
    errorMsg = null;

    products.clear();
    notifyListeners();
  }

  Future fetchProducts() async {
    try {
      _resetState();

      await _prepareRealProducts();
      // _prepareFakeProducts();

      // Timer.periodic(
      //   const Duration(milliseconds: 350),
      //   (timer) async {
      //     progress += 0.1;
      //     progress = double.parse(progress.toStringAsFixed(1));
      //     print(progress);
      //     notifyListeners();
      //     if (progress >= 1.0) {
      //       timer.cancel();
      //       await Future.delayed(const Duration(seconds: 1));
      //       isLoading = false;
      //       notifyListeners();
      //     }
      //   },
      // );
      isLoading = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addProduct(String name) async {
    bool output = false;
    isError = false;

    Product product = Product(name: name, productDetail: null);

    final url = Uri.http(kApiDomain, '$kApiBaseEndpoint/products');
    final response = await http.post(
      url,
      headers: kApiDefaultHeaders,
      body: jsonEncode(
        product.toJSON(),
      ),
    );
    inspect(response);
    if (response.statusCode == 201) {
      isLoading = false;
      isEmpty = false;
      Product product = Product.fromJSON(jsonDecode(response.body)['data']);
      products.add(product);
      inspect(products);
      output = true;
    } else {
      isLoading = false;
      isEmpty = false;
      isError = true;
      errorMsg = "Something went wrong!!!";

      output = false;
    }

    notifyListeners();
    return output;
  }

  Future<void> _prepareRealProducts() async {
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
  }

  Future<void> _prepareFakeProducts() async {
    products = [...generateFakeProducts()];
    inspect(products);
    if (products.isEmpty) {
      isEmpty = true;
    }
  }
}
