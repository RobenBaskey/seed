import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_card.dart';

/// KPI tile for dashboards: an icon, a big value, a label, and an
/// optional trend delta (e.g. "+12% vs last month").
class StatisticCard extends StatelessWidget {
  const StatisticCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.trendLabel,
    this.isTrendPositive = true,
    this.onTap,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final String? trendLabel;
  final bool isTrendPositive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final accent = iconColor ?? AppColors.primary;

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (icon != null)
                Container(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(icon, size: 18, color: accent),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: AppTextStyles.displaySmall),
          if (trendLabel != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isTrendPositive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                  size: 14,
                  color: isTrendPositive ? AppColors.success : AppColors.error,
                ),
                const SizedBox(width: AppSpacing.xxs),
                Text(
                  trendLabel!,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isTrendPositive ? AppColors.successText : AppColors.errorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
