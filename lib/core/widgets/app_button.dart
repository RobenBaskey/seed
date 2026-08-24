import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';
import '../theme/app_text_styles.dart';

enum AppButtonVariant { primary, secondary, tertiary, danger }

enum AppButtonSize { small, medium, large }

/// The app's single button component. Use [variant] to pick the visual
/// weight (primary CTA vs. outline vs. plain text vs. destructive) and
/// [size] to pick the height — default is [AppButtonSize.large] (52dp)
/// since this app is meant to stay usable with gloves or in the field.
///
/// Colors and disabled-state dimming come from the button themes set up
/// in [AppTheme]; this widget only overrides size-related geometry
/// (height/padding/shape) and the danger-variant background.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.large,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  double get _height => switch (size) {
        AppButtonSize.small => 36,
        AppButtonSize.medium => 44,
        AppButtonSize.large => AppSpacing.minTouchTarget,
      };

  double get _horizontalPadding => switch (size) {
        AppButtonSize.small => AppSpacing.md,
        AppButtonSize.medium || AppButtonSize.large => AppSpacing.lg,
      };

  TextStyle get _labelStyle {
    final base = size == AppButtonSize.small ? AppTextStyles.labelMedium : AppTextStyles.labelLarge;
    return base.copyWith(fontWeight: FontWeight.w600);
  }

  ButtonStyle get _geometryStyle {
    final geometry = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(0, _height)),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: _horizontalPadding)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.button))),
      textStyle: WidgetStatePropertyAll(_labelStyle),
    );
    if (variant == AppButtonVariant.danger) {
      return geometry.merge(ElevatedButton.styleFrom(backgroundColor: AppColors.error));
    }
    return geometry;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isFilled = variant == AppButtonVariant.primary || variant == AppButtonVariant.danger;
    final accentColor = isFilled ? colorScheme.onPrimary : colorScheme.primary;

    final child = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2.4, color: accentColor),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: accentColor),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(label),
            ],
          );

    final Widget button = switch (variant) {
      AppButtonVariant.primary ||
      AppButtonVariant.danger =>
        ElevatedButton(style: _geometryStyle, onPressed: isLoading ? null : onPressed, child: child),
      AppButtonVariant.secondary =>
        OutlinedButton(style: _geometryStyle, onPressed: isLoading ? null : onPressed, child: child),
      AppButtonVariant.tertiary =>
        TextButton(style: _geometryStyle, onPressed: isLoading ? null : onPressed, child: child),
    };

    return SizedBox(width: isFullWidth ? double.infinity : null, child: button);
  }
}
