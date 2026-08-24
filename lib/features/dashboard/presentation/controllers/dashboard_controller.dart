import 'package:get/get.dart';

import '../../../../core/navigation/app_nav_items.dart';
import '../../../auth/domain/entities/permission.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class DashboardController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  /// Nav destinations the signed-in user's role is permitted to see.
  /// Read this from inside an `Obx` — it depends on
  /// `authController.currentUser`, a reactive value.
  List<AppNavItem> get visibleNavItems {
    final role = authController.currentUser.value?.role;
    if (role == null) return const [];
    return AppNavItems.all.where((item) => role.hasPermission(item.permission)).toList();
  }

  void logout() => authController.logout();
}
