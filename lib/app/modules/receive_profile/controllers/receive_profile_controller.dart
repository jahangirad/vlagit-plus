import 'package:get/get.dart';

class ReceiveProfileController extends GetxController {
  late Map<String, dynamic> profile;

  @override
  void onInit() {
    super.onInit();
    profile = Get.arguments ?? {};
  }
}
