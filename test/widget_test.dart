// Widget-level smoke test for the login screen: renders correctly, and a
// demo-account shortcut can log a user in end-to-end through the real
// AuthController/use cases (only the storage plugin is faked).

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:seed/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:seed/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:seed/features/auth/domain/usecases/login_usecase.dart';
import 'package:seed/features/auth/domain/usecases/logout_usecase.dart';
import 'package:seed/features/auth/presentation/controllers/auth_controller.dart';
import 'package:seed/features/auth/presentation/pages/login_page.dart';

import 'helpers/fake_auth_local_data_source.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    final repository = AuthRepositoryImpl(
      remoteDataSource: DemoAuthRemoteDataSourceImpl(),
      localDataSource: FakeAuthLocalDataSource(),
    );
    Get.put<AuthController>(
      AuthController(
        loginUseCase: LoginUseCase(repository),
        logoutUseCase: LogoutUseCase(repository),
        getCurrentUserUseCase: GetCurrentUserUseCase(repository),
      ),
    );
  });

  tearDown(Get.reset);

  Widget wrapWithApp(Widget child) {
    return GetMaterialApp(
      home: child,
      getPages: [
        GetPage(name: AppRoutes.dashboard, page: () => const SizedBox()),
      ],
    );
  }

  testWidgets('Login screen renders demo account shortcuts for all 5 roles', (tester) async {
    await tester.pumpWidget(wrapWithApp(const LoginPage()));
    await tester.pumpAndSettle();

    expect(find.text('Sign in to your account'), findsOneWidget);
    for (final label in ['Admin', 'Manager', 'Sales Representative', 'Field Officer', 'Dealer']) {
      expect(find.text(label), findsOneWidget);
    }
  });

  testWidgets('Tapping the Admin shortcut and logging in authenticates the user', (tester) async {
    await tester.pumpWidget(wrapWithApp(const LoginPage()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Admin'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    expect(Get.find<AuthController>().isLoggedIn, isTrue);
    expect(Get.find<AuthController>().currentUser.value?.email, 'admin@seedapp.com');
  });

  testWidgets('Wrong password is rejected and the user stays logged out', (tester) async {
    await tester.pumpWidget(wrapWithApp(const LoginPage()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'admin@seedapp.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrong-password');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    final authController = Get.find<AuthController>();
    expect(authController.isLoggedIn, isFalse);
    expect(authController.errorMessage.value, isNotEmpty);

    // Let the login-failed snackbar's overlay animation and dismiss
    // timer finish before the test tears down the widget tree, otherwise
    // flutter_test flags them as leaked.
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
