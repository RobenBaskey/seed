import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../theme/app_text_styles.dart';

/// Standard loading indicator, used both for a full-screen/section
/// loading state (with an optional [message]) and inline within smaller
/// areas via [size].
class LoadingState extends StatelessWidget {
  const LoadingState({super.key, this.message, this.size = 32});

  final String? message;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: size,
            width: size,
            child: const CircularProgressIndicator(strokeWidth: 2.5),
          ),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              message!,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
