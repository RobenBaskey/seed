import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

/// Standard app button with a built-in loading state, so features don't
/// each re-implement the disabled/spinner logic on `ElevatedButton`.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: AppSpacing.md,
              width: AppSpacing.md,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : Text(label),
    );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
