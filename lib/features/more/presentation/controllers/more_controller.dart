import 'package:get/get.dart';

import '../../../auth/presentation/controllers/auth_controller.dart';

class MoreController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  void logout() => authController.logout();
}
