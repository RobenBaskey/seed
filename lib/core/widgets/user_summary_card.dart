import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_card.dart';
import 'status_chip.dart';

/// Avatar + name + role badge, used on both the Home tab and the More
/// screen so the "who am I signed in as" summary only has one
/// implementation to keep in sync.
class UserSummaryCard extends StatelessWidget {
  const UserSummaryCard({super.key, required this.name, required this.roleLabel});

  final String name;
  final String roleLabel;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary50,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: AppTextStyles.headlineSmall.copyWith(color: AppColors.primary700),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.titleLarge),
                const SizedBox(height: AppSpacing.xxs),
                StatusChip(label: roleLabel, type: StatusChipType.success),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
