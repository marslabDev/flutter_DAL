import 'package:flutter/material.dart';
import 'package:flutter_model_relation/models/product.dart';
import 'package:flutter_model_relation/providers/product_provider.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  final String? title;
  // final Product? product;

  const AddProductScreen({
    super.key,
    required this.title,
    // required this.product,
  });

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final title = widget.title;

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _productNameInput,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Product Name',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<ProductProvider>(context, listen: false)
                .addProduct(_productNameInput.text)
                .then((value) {
              if (value) {
                Navigator.pop(context);
              }
            });
          },
          backgroundColor: Colors.purple,
          child: const Icon(Icons.save),
        ),
    );
  }
}
