import 'package:get/get.dart';
import '../network/dio_client.dart';

/// Registers app-wide singletons that every feature can depend on.
/// Wired into `GetMaterialApp.initialBinding` in main.dart, so these are
/// available before the first route loads. Feature-scoped dependencies
/// belong in that feature's own `<feature>_binding.dart` instead.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DioClient>(DioClient(), permanent: true);
  }
}
