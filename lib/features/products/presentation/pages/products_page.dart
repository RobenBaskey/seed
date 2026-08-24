import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/products_controller.dart';

/// Placeholder screen for the Products feature.
class ProductsPage extends GetView<ProductsController> {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: const Center(child: Text('Products feature coming soon')),
    );
  }
}
