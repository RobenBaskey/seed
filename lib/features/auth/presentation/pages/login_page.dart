import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/widgets.dart';
import '../../domain/entities/demo_account.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _fillDemoAccount(DemoAccount account) {
    setState(() {
      _emailController.text = account.email;
      _passwordController.text = account.password;
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await _authController.login(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (!mounted) return;

    if (success) {
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      Get.snackbar(
        'Login failed',
        _authController.errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primary600,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: const Icon(Icons.eco_rounded, color: AppColors.textOnPrimary, size: 32),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    AppStrings.appName,
                    style: AppTextStyles.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    'Sign in to your account',
                    style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppTextField(
                            controller: _emailController,
                            label: 'Email',
                            hintText: 'name@seedapp.com',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            prefixIcon: Icons.mail_outline_rounded,
                            validator: Validators.email,
                            autofillHints: const [AutofillHints.email],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          AppTextField(
                            controller: _passwordController,
                            label: 'Password',
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            prefixIcon: Icons.lock_outline_rounded,
                            validator: Validators.password,
                            onFieldSubmitted: (_) => _submit(),
                            autofillHints: const [AutofillHints.password],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Obx(
                            () => AppButton(
                              label: 'Login',
                              isLoading: _authController.isLoading.value,
                              onPressed: _submit,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'DEMO ACCOUNTS — TAP TO FILL',
                    style: AppTextStyles.labelSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: DemoAccounts.all.map((account) {
                      return ActionChip(
                        avatar: const Icon(Icons.person_outline_rounded, size: 16),
                        label: Text(account.role.displayName),
                        onPressed: () => _fillDemoAccount(account),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
