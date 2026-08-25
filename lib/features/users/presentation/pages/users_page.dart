import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/app_shell.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/users_controller.dart';

/// Placeholder screen for the Users feature.
class UsersPage extends GetView<UsersController> {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('Users')),
      body: const EmptyState(
        icon: Icons.group_outlined,
        title: 'Users',
        message: 'Users is coming soon.',
      ),
    );
  }
}
