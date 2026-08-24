// Private fields are assigned from public-named constructor params on
// purpose so the class is still constructible by name from other files
// (an initializing formal on a private field can't be).
// ignore_for_file: prefer_initializing_formals
import 'package:get/get.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/permission.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

/// App-wide auth state and actions. Registered as a permanent singleton
/// during bootstrap (see core/di/initial_binding.dart) because route
/// middlewares must be able to read it before any page's own binding
/// runs.
class AuthController extends GetxController {
  AuthController({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  })  : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _getCurrentUserUseCase = getCurrentUserUseCase;

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  final Rx<User?> currentUser = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  bool get isLoggedIn => currentUser.value != null;

  /// Loads a previously persisted session, if any. Call once from
  /// `main()` before `runApp`, so the very first frame already reflects
  /// whether the user is signed in.
  Future<void> restoreSession() async {
    try {
      currentUser.value = await _getCurrentUserUseCase(const NoParams());
    } catch (_) {
      currentUser.value = null;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      currentUser.value = await _loginUseCase(LoginParams(email: email, password: password));
      return true;
    } on Failure catch (failure) {
      errorMessage.value = failure.message;
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _logoutUseCase(const NoParams());
    currentUser.value = null;
    Get.offAllNamed(AppRoutes.login);
  }

  bool hasPermission(Permission permission) {
    final role = currentUser.value?.role;
    if (role == null) return false;
    return role.hasPermission(permission);
  }
}
