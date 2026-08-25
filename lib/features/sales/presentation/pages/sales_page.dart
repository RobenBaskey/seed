import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_shell.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/sales_controller.dart';

/// Placeholder screen for the Sales feature.
class SalesPage extends GetView<SalesController> {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Sales')),
      body: const EmptyState(
        icon: Icons.insights_outlined,
        title: 'Sales',
        message: 'Sales is coming soon.',
      ),
    );
  }
}
