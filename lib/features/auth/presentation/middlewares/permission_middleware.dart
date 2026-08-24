import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/permission.dart';
import '../controllers/auth_controller.dart';

/// Redirects to the dashboard if the signed-in user's role lacks
/// [requiredPermission]. Pair with [AuthMiddleware] (lower priority runs
/// first) on any [GetPage] restricted to specific roles.
class PermissionMiddleware extends GetMiddleware {
  PermissionMiddleware(this.requiredPermission);

  final Permission requiredPermission;

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;

    if (user == null) {
      return const RouteSettings(name: AppRoutes.login);
    }
    if (!user.role.hasPermission(requiredPermission)) {
      Get.snackbar(
        'Access denied',
        'You do not have permission to view this page.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return RouteSettings(name: AppRoutes.dashboardForRole(user.role));
    }
    return null;
  }
}
