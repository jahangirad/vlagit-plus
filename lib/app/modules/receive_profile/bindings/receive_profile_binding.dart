import 'package:get/get.dart';

import '../controllers/receive_profile_controller.dart';

class ReceiveProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiveProfileController>(
      () => ReceiveProfileController(),
    );
  }
}
