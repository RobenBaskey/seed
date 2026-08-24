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
  late FakeAuthLocalDataSource fakeLocalDataSource;

  setUp(() {
    Get.testMode = true;
    fakeLocalDataSource = FakeAuthLocalDataSource();
    final repository = AuthRepositoryImpl(
      remoteDataSource: DemoAuthRemoteDataSourceImpl(),
      localDataSource: fakeLocalDataSource,
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
        for (final route in AppRoutes.dashboardRoutes) GetPage(name: route, page: () => const SizedBox()),
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

  testWidgets('Logging in as Admin authenticates and routes to the admin dashboard', (tester) async {
    await tester.pumpWidget(wrapWithApp(const LoginPage()));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Admin'));
    await tester.tap(find.text('Admin'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    final authController = Get.find<AuthController>();
    expect(authController.isLoggedIn, isTrue);
    expect(authController.currentUser.value?.email, 'admin@seedapp.com');
    expect(Get.currentRoute, AppRoutes.adminDashboard);
  });

  testWidgets('Logging in as Dealer routes to the dealer dashboard', (tester) async {
    await tester.pumpWidget(wrapWithApp(const LoginPage()));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Dealer'));
    await tester.tap(find.text('Dealer'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    expect(Get.currentRoute, AppRoutes.dealerDashboard);
  });

  testWidgets('Wrong password shows an inline error and the user stays logged out', (tester) async {
    await tester.pumpWidget(wrapWithApp(const LoginPage()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'admin@seedapp.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'wrong-password');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    final authController = Get.find<AuthController>();
    expect(authController.isLoggedIn, isFalse);
    expect(find.text('Invalid email or password'), findsOneWidget);
  });

  testWidgets('Unchecking Remember me still logs in but does not persist the session', (tester) async {
    await tester.pumpWidget(wrapWithApp(const LoginPage()));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Admin'));
    await tester.tap(find.text('Admin'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byType(Checkbox));
    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    await tester.pumpAndSettle();

    final authController = Get.find<AuthController>();
    expect(authController.isLoggedIn, isTrue);
    expect(await fakeLocalDataSource.getCachedUser(), isNull);
  });

  testWidgets('Forgot password opens a dialog and can be dismissed', (tester) async {
    await tester.pumpWidget(wrapWithApp(const LoginPage()));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Forgot password?'));
    await tester.tap(find.text('Forgot password?'));
    await tester.pumpAndSettle();

    expect(find.text('Reset password'), findsOneWidget);
    expect(
      find.text("Enter your account email and we'll send you a link to reset your password."),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Reset password'), findsNothing);
  });
}
