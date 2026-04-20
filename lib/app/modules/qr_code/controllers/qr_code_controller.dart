import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeController extends GetxController {
  // Simple initialization for v7.2.0 compatibility
  final MobileScannerController scannerController = MobileScannerController(
    autoStart: false,
  );

  @override
  void onReady() {
    super.onReady();
    // Manual start after a small delay to ensure native view is ready
    Future.delayed(const Duration(milliseconds: 400), () {
      scannerController.start();
    });
  }

  @override
  void onClose() {
    scannerController.stop();
    scannerController.dispose();
    super.onClose();
  }
}
