import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_shell.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/payments_controller.dart';

/// Placeholder screen for the Payments feature.
class PaymentsPage extends GetView<PaymentsController> {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Payments')),
      body: const EmptyState(
        icon: Icons.payments_outlined,
        title: 'Payments',
        message: 'Payments is coming soon.',
      ),
    );
  }
}
