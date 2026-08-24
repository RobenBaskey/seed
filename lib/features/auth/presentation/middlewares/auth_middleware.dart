import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/routes/app_routes.dart';
import '../controllers/auth_controller.dart';

/// Redirects unauthenticated users away from protected routes, and
/// authenticated users away from the login screen. Attach to every
/// [GetPage] that requires a logged-in session.
class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 0;

  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    if (!authController.isLoggedIn && route != AppRoutes.login) {
      return const RouteSettings(name: AppRoutes.login);
    }
    if (authController.isLoggedIn && route == AppRoutes.login) {
      return const RouteSettings(name: AppRoutes.dashboard);
    }
    return null;
  }
}
