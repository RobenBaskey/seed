import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_shell.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/visits_controller.dart';

/// Placeholder screen for the Field (visits) feature — shared by the
/// Sales Representative and Field Officer roles, who each land here
/// from their own "Field" tab.
class VisitsPage extends GetView<VisitsController> {
  const VisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Field')),
      body: const EmptyState(
        icon: Icons.map_outlined,
        title: 'Field',
        message: 'Field visits are coming soon.',
      ),
    );
  }
}
