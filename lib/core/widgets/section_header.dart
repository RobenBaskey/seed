import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Title (+ optional subtitle and trailing action) used to introduce a
/// section of a screen — keeps that pattern's spacing/typography
/// consistent everywhere instead of every screen rebuilding it.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.headlineSmall),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.xxs),
                Text(subtitle!, style: AppTextStyles.bodySmall),
              ],
            ],
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onActionTap,
            child: Text(actionLabel!),
          ),
      ],
    );
  }
}
