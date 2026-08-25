import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_shell.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/orders_controller.dart';

/// Placeholder screen for the Orders feature.
class OrdersPage extends GetView<OrdersController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Orders')),
      body: const EmptyState(
        icon: Icons.receipt_long_outlined,
        title: 'Orders',
        message: 'Orders is coming soon.',
      ),
    );
  }
}
