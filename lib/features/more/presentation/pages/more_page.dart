import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/navigation/app_shell.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/more_controller.dart';

/// The shared overflow menu every role lands on from the "More" tab —
/// account info plus the universal destinations (Notifications, Profile)
/// that don't need a tab of their own, and Logout. Same page for every
/// role; only the bottom nav around it changes.
class MorePage extends GetView<MoreController> {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      appBar: AppBar(title: const Text('More')),
      body: Obx(() {
        final user = controller.authController.currentUser.value;
        if (user == null) return const LoadingState();

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            UserSummaryCard(name: user.name, roleLabel: user.role.displayName),
            const SizedBox(height: AppSpacing.md),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _MoreListTile(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    onTap: () => Get.toNamed(AppRoutes.notifications),
                  ),
                  const Divider(height: 1),
                  _MoreListTile(
                    icon: Icons.person_outline_rounded,
                    label: 'Profile',
                    onTap: () => Get.toNamed(AppRoutes.profile),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Logout',
              variant: AppButtonVariant.danger,
              icon: Icons.logout_rounded,
              onPressed: () => _confirmLogout(context),
            ),
          ],
        );
      }),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await ConfirmationDialog.show(
      context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      confirmLabel: 'Logout',
      isDestructive: true,
    );
    if (confirmed) controller.logout();
  }
}

class _MoreListTile extends StatelessWidget {
  const _MoreListTile({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(label, style: AppTextStyles.bodyLarge),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textTertiary),
      onTap: onTap,
    );
  }
}
