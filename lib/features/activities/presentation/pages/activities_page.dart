import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_shell.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/activities_controller.dart';

/// Placeholder screen for the Activities feature.
class ActivitiesPage extends GetView<ActivitiesController> {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Activities')),
      body: const EmptyState(
        icon: Icons.task_alt_outlined,
        title: 'Activities',
        message: 'Activities is coming soon.',
      ),
    );
  }
}
