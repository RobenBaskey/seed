import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/navigation/role_navigation.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/auth_controller.dart';

/// Blocks a route from opening — via tab tap, `Get.toNamed`, or a direct
/// deep link — unless the signed-in user's role is one of
/// [RoleNavigation.allowedRolesForRoute] for it. A route with no
/// registered role (e.g. Notifications, Profile) is open to any
/// signed-in user. Pair with [AuthMiddleware] (lower priority runs
/// first) on every protected [GetPage].
class RoleGuardMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;
    if (user == null) return const RouteSettings(name: AppRoutes.login);

    if (route == null) return null;
    final allowedRoles = RoleNavigation.allowedRolesForRoute(route);
    if (allowedRoles.isNotEmpty && !allowedRoles.contains(user.role)) {
      return RouteSettings(name: AppRoutes.dashboardForRole(user.role));
    }
    return null;
  }
}
