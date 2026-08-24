import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/domain/entities/permission.dart';
import '../controllers/dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final role = controller.authController.currentUser.value?.role;
          return Text(role != null ? '${role.displayName} Dashboard' : 'Dashboard');
        }),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Logout',
            onPressed: () => _confirmLogout(context),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: Obx(() {
        final user = controller.authController.currentUser.value;
        if (user == null) return const LoadingState();

        final navItems = controller.visibleNavItems;
        final permissions = Permission.values.where(user.role.hasPermission).toList();

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary50,
                  child: Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    style: AppTextStyles.headlineSmall.copyWith(color: AppColors.primary700),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome, ${user.name}', style: AppTextStyles.headlineSmall),
                      const SizedBox(height: AppSpacing.xxs),
                      StatusChip(label: user.role.displayName, type: StatusChipType.success),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: StatisticCard(
                    label: 'Access level',
                    value: '${permissions.length}',
                    icon: Icons.verified_user_outlined,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: StatisticCard(
                    label: 'Modules',
                    value: '${navItems.length}',
                    icon: Icons.dashboard_customize_outlined,
                    iconColor: AppColors.secondary600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            const SectionHeader(title: 'Quick access'),
            const SizedBox(height: AppSpacing.md),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.md,
                crossAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.3,
              ),
              itemCount: navItems.length,
              itemBuilder: (context, index) {
                final item = navItems[index];
                return AppCard(
                  onTap: () => Get.toNamed(item.route),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.icon, size: 30, color: AppColors.primary),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        item.label,
                        style: AppTextStyles.titleSmall.copyWith(color: AppColors.textPrimary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            const SectionHeader(title: 'Your permissions'),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: permissions
                  .map((permission) => StatusChip(label: permission.displayName, type: StatusChipType.info))
                  .toList(),
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
