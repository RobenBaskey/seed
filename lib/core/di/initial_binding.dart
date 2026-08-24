import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../network/dio_client.dart';

/// Composition root: registers app-wide singletons every feature can
/// depend on. Run explicitly from `main()` (not `GetMaterialApp
/// .initialBinding`) so `AuthController.restoreSession()` can be awaited
/// before the widget tree — and its route middlewares — first build.
/// Feature-scoped, route-local dependencies belong in that feature's own
/// `<feature>_binding.dart` instead.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DioClient>(DioClient(), permanent: true);

    Get.put<AuthRemoteDataSource>(DemoAuthRemoteDataSourceImpl(), permanent: true);
    Get.put<AuthLocalDataSource>(AuthLocalDataSourceImpl(GetStorage()), permanent: true);
    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        remoteDataSource: Get.find(),
        localDataSource: Get.find(),
      ),
      permanent: true,
    );

    Get.put<LoginUseCase>(LoginUseCase(Get.find()), permanent: true);
    Get.put<LogoutUseCase>(LogoutUseCase(Get.find()), permanent: true);
    Get.put<GetCurrentUserUseCase>(GetCurrentUserUseCase(Get.find()), permanent: true);

    Get.put<AuthController>(
      AuthController(
        loginUseCase: Get.find(),
        logoutUseCase: Get.find(),
        getCurrentUserUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
