import 'package:flutter/material.dart';

import 'app_button.dart';

/// Standard confirm/cancel dialog. Prefer [ConfirmationDialog.show] over
/// constructing this directly — it wraps `showDialog` and resolves to a
/// plain `bool` (true only if the user tapped confirm).
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.isDestructive = false,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        AppButton(
          label: cancelLabel,
          variant: AppButtonVariant.tertiary,
          isFullWidth: false,
          size: AppButtonSize.medium,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        AppButton(
          label: confirmLabel,
          variant: isDestructive ? AppButtonVariant.danger : AppButtonVariant.primary,
          isFullWidth: false,
          size: AppButtonSize.medium,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
