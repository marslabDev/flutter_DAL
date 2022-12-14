import 'package:flutter/material.dart';
import 'package:flutter_model_relation/providers/product_provider.dart';
import 'package:flutter_model_relation/screens/product/product_screen.dart';
import 'package:provider/provider.dart';

import 'screens/home/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const HomeScreen(title: 'E-Comm App'),
        '/product': (context) => const ProductScreen(),
      },
    );
  }
}
