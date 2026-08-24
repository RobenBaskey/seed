import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Semantic meaning behind a [StatusChip] — drives its color pairing.
enum StatusChipType { success, warning, error, info, neutral }

/// Small pill used to show a status label (order state, sync state,
/// approval state, ...). Colors come from the semantic tokens in
/// [AppColors] so a given status always looks the same everywhere.
class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.label,
    this.type = StatusChipType.neutral,
    this.icon,
    this.showDot = false,
  });

  final String label;
  final StatusChipType type;
  final IconData? icon;
  final bool showDot;

  (Color bg, Color fg) get _colors => switch (type) {
        StatusChipType.success => (AppColors.successBg, AppColors.successText),
        StatusChipType.warning => (AppColors.warningBg, AppColors.warningText),
        StatusChipType.error => (AppColors.errorBg, AppColors.errorText),
        StatusChipType.info => (AppColors.infoBg, AppColors.infoText),
        StatusChipType.neutral => (AppColors.neutralStatusBg, AppColors.neutralStatusText),
      };

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = _colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(AppRadius.chip)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(right: AppSpacing.xs),
              decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
            ),
          ] else if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: AppSpacing.xxs),
          ],
          Text(label, style: AppTextStyles.labelMedium.copyWith(color: fg)),
        ],
      ),
    );
  }
}
