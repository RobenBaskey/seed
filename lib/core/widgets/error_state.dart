import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'app_button.dart';

/// Standard "something went wrong" state with an optional retry action.
/// Use for failed loads/requests instead of ad hoc error text per screen.
class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.message,
    this.title = 'Something went wrong',
    this.retryLabel = 'Try again',
    this.onRetry,
  });

  final String message;
  final String title;
  final String retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: const BoxDecoration(color: AppColors.errorBg, shape: BoxShape.circle),
              child: const Icon(Icons.error_outline_rounded, size: 40, color: AppColors.error),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(title, style: AppTextStyles.headlineSmall, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.xs),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: retryLabel,
                onPressed: onRetry,
                isFullWidth: false,
                size: AppButtonSize.medium,
                icon: Icons.refresh_rounded,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
