import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/widgets.dart';

/// Self-contained "forgot password" flow. Entirely client-side — there's
/// no backend yet, so submitting just simulates a delay and shows a
/// confirmation. Swap `_submit` for a real repository call once password
/// reset has an API behind it.
class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key, this.initialEmail});

  final String? initialEmail;

  static Future<void> show(BuildContext context, {String? initialEmail}) {
    return showDialog<void>(
      context: context,
      builder: (_) => ForgotPasswordDialog(initialEmail: initialEmail),
    );
  }

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _emailController = TextEditingController(text: widget.initialEmail);
  bool _isSubmitting = false;
  bool _submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      _isSubmitting = false;
      _submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reset password'),
      content: _submitted ? _buildConfirmation() : _buildForm(),
      actionsPadding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
      actions: _submitted
          ? [
              AppButton(
                label: 'Done',
                isFullWidth: false,
                size: AppButtonSize.medium,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ]
          : [
              AppButton(
                label: 'Cancel',
                variant: AppButtonVariant.tertiary,
                isFullWidth: false,
                size: AppButtonSize.medium,
                onPressed: () => Navigator.of(context).pop(),
              ),
              AppButton(
                label: 'Send reset link',
                isFullWidth: false,
                size: AppButtonSize.medium,
                isLoading: _isSubmitting,
                onPressed: _submit,
              ),
            ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Enter your account email and we'll send you a link to reset your password.",
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _emailController,
            label: 'Email',
            hintText: 'name@seedapp.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.mail_outline_rounded,
            validator: Validators.email,
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmation() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle_rounded, color: AppColors.success),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            'If an account exists for that email, a reset link is on its way.',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
