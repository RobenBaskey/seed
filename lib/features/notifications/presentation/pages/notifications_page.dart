import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/widgets.dart';
import '../controllers/notifications_controller.dart';

/// Placeholder screen for the Notifications feature. Reached from the
/// More tab (pushed on top), so it deliberately has no bottom nav of
/// its own — the back arrow returns to More.
class NotificationsPage extends GetView<NotificationsController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: const EmptyState(
        icon: Icons.notifications_outlined,
        title: 'Notifications',
        message: 'Notifications are coming soon.',
      ),
    );
  }
}
