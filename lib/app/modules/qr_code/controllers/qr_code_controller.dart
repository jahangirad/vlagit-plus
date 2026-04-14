import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeController extends GetxController {
  final MobileScannerController scannerController = MobileScannerController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}
