import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../product/product_screen.dart';

class ProductItemCard extends StatelessWidget {
  final Product product;

  const ProductItemCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            product.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            product.productDetail!.price,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (product.categories != null)
            ...product.categories!.map(
              (e) => Text(
                e.name,
              ),
            ),
          if (product.tags != null)
            ...product.tags!.map(
              (e) => Chip(
                label: Text(e.name),
              ),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/product',
                arguments: ProductScreenArgs(
                  title: product.name,
                  product: product,
                ),
              );
            },
            child: const Text('View Product'),
          ),
        ],
      ),
    );
  }
}
