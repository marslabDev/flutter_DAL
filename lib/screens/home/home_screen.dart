import 'package:flutter/material.dart';
import 'package:flutter_model_relation/providers/product_provider.dart';
import 'package:flutter_model_relation/routes/router.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                RouteList.addProduct,
              );
            },
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0,
                  end: value.progress,
                ),
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // LinearProgressIndicator(
                        //   value: value,
                        // ),
                        const CircularProgressIndicator(),
                        const SizedBox(height: 8),
                        Text(
                          "${(value * 100).toInt()}%",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  );
                },
              ),
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

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: value.products.length,
            itemBuilder: (context, index) {
              return ProductItemCard(product: value.products[index]);
            },
          );
        },
      ),
      floatingActionButton: Consumer<ProductProvider>(
        builder: (context, value, child) {
          return value.isLoading
              ? Container()
              : FloatingActionButton(
                  onPressed: () {
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
