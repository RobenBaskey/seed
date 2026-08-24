import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // AuthController is a permanent singleton registered in
    // core/di/initial_binding.dart during app bootstrap — AuthMiddleware
    // needs it before any page binding runs. Nothing to register here;
    // this file exists for structural symmetry with other features.
  }
}
