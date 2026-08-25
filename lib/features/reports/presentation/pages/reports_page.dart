import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_shell.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/reports_controller.dart';

/// Placeholder screen for the Reports feature.
class ReportsPage extends GetView<ReportsController> {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Reports')),
      body: const EmptyState(
        icon: Icons.assessment_outlined,
        title: 'Reports',
        message: 'Reports is coming soon.',
      ),
    );
  }
}
