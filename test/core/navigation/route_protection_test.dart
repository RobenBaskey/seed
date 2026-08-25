// End-to-end route protection: drives the real AppPages route table (not
// a stub) to confirm RoleGuardMiddleware actually blocks a role from a
// route that isn't in its tab bar, whether reached via a tab tap or a
// direct `Get.toNamed` "deep link".

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:seed/core/routes/app_pages.dart';
import 'package:seed/core/routes/app_routes.dart';
import 'package:seed/core/theme/app_theme.dart';
import 'package:seed/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:seed/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:seed/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:seed/features/auth/domain/usecases/login_usecase.dart';
import 'package:seed/features/auth/domain/usecases/logout_usecase.dart';
import 'package:seed/features/auth/presentation/controllers/auth_controller.dart';

import '../../helpers/fake_auth_local_data_source.dart';

// `login()` internally awaits a `Future.delayed` (see
// DemoAuthRemoteDataSourceImpl) to simulate network latency. Under
// flutter_test's fake clock that timer only fires when a pump()
// advances it, so signing in before `pumpWidget` needs `runAsync` to
// let it resolve in real time instead of hanging forever.
Future<void> _signIn(WidgetTester tester, String email) async {
  Get.testMode = true;
  final repository = AuthRepositoryImpl(
    remoteDataSource: DemoAuthRemoteDataSourceImpl(),
    localDataSource: FakeAuthLocalDataSource(),
  );
  final authController = AuthController(
    loginUseCase: LoginUseCase(repository),
    logoutUseCase: LogoutUseCase(repository),
    getCurrentUserUseCase: GetCurrentUserUseCase(repository),
  );
  Get.put<AuthController>(authController);
  await tester.runAsync(() => authController.login(email: email, password: '123456'));
}

Widget _buildApp(String initialRoute) {
  return GetMaterialApp(
    theme: AppTheme.lightTheme,
    initialRoute: initialRoute,
    getPages: AppPages.pages,
  );
}

void main() {
  tearDown(Get.reset);

  testWidgets('A Dealer cannot open an Admin-only route via a direct route call', (tester) async {
    await _signIn(tester, 'dealer@seedapp.com');
    await tester.pumpWidget(_buildApp(AppRoutes.dealerDashboard));
    await tester.pumpAndSettle();
    expect(Get.currentRoute, AppRoutes.dealerDashboard);

    Get.toNamed(AppRoutes.users);
    await tester.pumpAndSettle();

    // Blocked: bounced back to the Dealer's own dashboard, not Users.
    expect(Get.currentRoute, AppRoutes.dealerDashboard);
  });

  testWidgets('A Dealer can open their own Products tab', (tester) async {
    await _signIn(tester, 'dealer@seedapp.com');
    await tester.pumpWidget(_buildApp(AppRoutes.dealerDashboard));
    await tester.pumpAndSettle();

    Get.toNamed(AppRoutes.products);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, AppRoutes.products);
  });

  testWidgets('An Admin cannot open a Dealer-only route (Products)', (tester) async {
    await _signIn(tester, 'admin@seedapp.com');
    await tester.pumpWidget(_buildApp(AppRoutes.adminDashboard));
    await tester.pumpAndSettle();

    Get.toNamed(AppRoutes.products);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, AppRoutes.adminDashboard);
  });

  testWidgets('An Admin can open Users and Reports', (tester) async {
    await _signIn(tester, 'admin@seedapp.com');
    await tester.pumpWidget(_buildApp(AppRoutes.adminDashboard));
    await tester.pumpAndSettle();

    Get.toNamed(AppRoutes.users);
    await tester.pumpAndSettle();
    expect(Get.currentRoute, AppRoutes.users);

    Get.toNamed(AppRoutes.reports);
    await tester.pumpAndSettle();
    expect(Get.currentRoute, AppRoutes.reports);
  });

  testWidgets('Notifications and Profile are reachable by every role', (tester) async {
    await _signIn(tester, 'field@seedapp.com');
    await tester.pumpWidget(_buildApp(AppRoutes.fieldDashboard));
    await tester.pumpAndSettle();

    Get.toNamed(AppRoutes.notifications);
    await tester.pumpAndSettle();
    expect(Get.currentRoute, AppRoutes.notifications);

    Get.back();
    await tester.pumpAndSettle();

    Get.toNamed(AppRoutes.profile);
    await tester.pumpAndSettle();
    expect(Get.currentRoute, AppRoutes.profile);
  });

  testWidgets('Tapping a bottom nav tab navigates to that tab\'s route', (tester) async {
    await _signIn(tester, 'manager@seedapp.com');
    await tester.pumpWidget(_buildApp(AppRoutes.managerDashboard));
    await tester.pumpAndSettle();

    // Manager's tabs: Home, Sales, Dealers, Orders, More. Scope the
    // finder to the nav bar itself — "Dealers" also appears in the
    // Home tab's "Your tools" chip list.
    final dealersTab = find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text('Dealers'),
    );
    await tester.tap(dealersTab);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, AppRoutes.dealers);
  });
}
