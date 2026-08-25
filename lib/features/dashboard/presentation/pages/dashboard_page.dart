import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/navigation/app_shell.dart';
import '../../../../core/navigation/role_navigation.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(
        title: Obx(() {
          final role = controller.authController.currentUser.value?.role;
          return Text(role != null ? '${role.displayName} Dashboard' : 'Dashboard');
        }),
      ),
      body: Obx(() {
        final user = controller.authController.currentUser.value;
        if (user == null) return const LoadingState();

        final otherTabs = RoleNavigation.primaryTabsFor(user.role)
            .where((tab) => tab.label != 'Home' && tab.label != 'More')
            .toList();

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            UserSummaryCard(name: user.name, roleLabel: user.role.displayName),
            const SizedBox(height: AppSpacing.xl),
            const SectionHeader(title: 'Your tools'),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Get around using the tabs below.',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final tab in otherTabs)
                  Chip(avatar: Icon(tab.icon, size: 18), label: Text(tab.label)),
              ],
            ),
          ],
        );
      }),
    );
  }
}
