import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_shell.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/products_controller.dart';

/// Placeholder screen for the Products feature.
class ProductsPage extends GetView<ProductsController> {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Products')),
      body: const EmptyState(
        icon: Icons.inventory_2_outlined,
        title: 'Products',
        message: 'Products is coming soon.',
      ),
    );
  }
}
