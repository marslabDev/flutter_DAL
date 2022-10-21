import 'package:flutter/material.dart';
import 'package:flutter_model_relation/providers/product_provider.dart';
import 'package:flutter_model_relation/screens/home/widgets/product_item_card.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (value.isError) {
            return Center(
              child: Text(value.errorMsg ?? ''),
            );
          }

          if (value.isEmpty) {
            return const Center(
              child: Text('No data'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: value.products.length,
                itemBuilder: (context, index) {
                  return ProductItemCard(product: value.products[index]);
                }),
          );
        },
      ),
      floatingActionButton: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return FloatingActionButton(
            onPressed: value.isLoading
                ? null
                : () {
                    Provider.of<ProductProvider>(context, listen: false)
                        .fetchProducts();
                  },
            child: const Icon(Icons.refresh),
          );
        },
      ),
    );
  }
}
