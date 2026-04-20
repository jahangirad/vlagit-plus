import 'package:get/get.dart';

import '../../edit_profile/controllers/edit_profile_controller.dart';
import '../../nearby/controllers/nearby_controller.dart';
import '../../preview/controllers/preview_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../qr_code/controllers/qr_code_controller.dart';
import '../../receive/controllers/receive_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(),
    );
    Get.lazyPut<PreviewController>(
      () => PreviewController(),
    );
    // Get.lazyPut<QrCodeController>(
    //   () => QrCodeController(),
    // );
    Get.lazyPut<NearbyController>(
      () => NearbyController(),
    );
    Get.lazyPut<ReceiveController>(
      () => ReceiveController(),
    );
    // Get.lazyPut<ProfileController>(
    //   () => ProfileController(),
    // );
  }
}
