import 'package:flutter/material.dart';
import 'package:flutter_model_relation/models/product.dart';

class ProductScreenArgs {
  final String? title;
  final Product? product;

  ProductScreenArgs({
    this.title,
    this.product,
  });
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ProductScreenArgs;
    final title = args.title;
    final product = args.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              product!.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              product.productDetail!.price,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            if (product.categories != null)
              ...product.categories!.map((e) => Text(
                    e.name,
                  )),
            if (product.tags != null)
              ...product.tags!.map(
                (e) => Text(e.name),
              ),
          ],
        ),
      ),
    );
  }
}
