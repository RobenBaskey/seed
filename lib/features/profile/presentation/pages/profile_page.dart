import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/widgets.dart';
import '../controllers/profile_controller.dart';

/// Placeholder screen for the Profile feature. Reached from the More
/// tab (pushed on top), so it deliberately has no bottom nav of its
/// own — the back arrow returns to More.
class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const EmptyState(
        icon: Icons.person_outline_rounded,
        title: 'Profile',
        message: 'Profile editing is coming soon.',
      ),
    );
  }
}
