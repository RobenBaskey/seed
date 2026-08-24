import 'package:get/get.dart';
import '../controllers/dealers_controller.dart';

class DealersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DealersController>(() => DealersController());
  }
}
