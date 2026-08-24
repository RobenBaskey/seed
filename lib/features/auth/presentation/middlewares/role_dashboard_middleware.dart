import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../controllers/auth_controller.dart';

/// Keeps a signed-in user on their own role's dashboard route — a Dealer
/// hitting `/admin-dashboard` directly gets bounced to
/// `/dealer-dashboard` instead of landing on the wrong shell. Pair with
/// [AuthMiddleware] (lower priority runs first) on each dashboard route.
class RoleDashboardMiddleware extends GetMiddleware {
  @override
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;
    if (user == null) return const RouteSettings(name: AppRoutes.login);

    final correctRoute = AppRoutes.dashboardForRole(user.role);
    if (route != correctRoute) {
      return RouteSettings(name: correctRoute);
    }
    return null;
  }
}
