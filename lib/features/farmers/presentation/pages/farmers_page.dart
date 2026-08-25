import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_shell.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/farmers_controller.dart';

/// Placeholder screen for the Farmers feature.
class FarmersPage extends GetView<FarmersController> {
  const FarmersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Farmers')),
      body: const EmptyState(
        icon: Icons.agriculture_outlined,
        title: 'Farmers',
        message: 'Farmers is coming soon.',
      ),
    );
  }
}
