import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_shell.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/dealers_controller.dart';

/// Placeholder screen for the Dealers feature.
class DealersPage extends GetView<DealersController> {
  const DealersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Dealers')),
      body: const EmptyState(
        icon: Icons.storefront_outlined,
        title: 'Dealers',
        message: 'Dealers is coming soon.',
      ),
    );
  }
}
