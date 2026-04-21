import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import '../../qr_code/controllers/qr_code_controller.dart';

class PreviewController extends GetxController {
  final storage = GetStorage();
  final ScreenshotController screenshotController = ScreenshotController();

  var fullName = ''.obs;
  var title = ''.obs;
  var imagePath = ''.obs;
  var qrContent = ''.obs;
  var isSharing = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPreviewData();
  }

  void refreshData() {
    loadPreviewData();
  }

  void loadPreviewData() {
    fullName.value = storage.read('fullName') ?? 'Your Name';
    title.value = storage.read('title') ?? 'Your Title';
    imagePath.value = storage.read('imagePath') ?? '';
    
    // Instead of reading old JSON from storage, generate fresh text payload
    try {
      final qrCtrl = Get.find<QrCodeController>();
      qrContent.value = qrCtrl.generatePayload();
    } catch (e) {
      // Fallback if QrCodeController isn't initialized yet
      qrContent.value = storage.read('qrContent') ?? 'No Data';
    }
  }

  Future<void> captureAndShare() async {
    try {
      isSharing.value = true;
      
      // Critical delay: Give Flutter 200ms to render the footer assets before capture
      await Future.delayed(const Duration(milliseconds: 200));

      final image = await screenshotController.capture(pixelRatio: 3.0);
      isSharing.value = false;

      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final String path = '${directory.path}/vlagit_share_${DateTime.now().millisecondsSinceEpoch}.png';
        final file = File(path);
        await file.writeAsBytes(image);

        await Share.shareXFiles([XFile(path)], text: 'Check out my VLAGIT profile!');
      }
    } catch (e) {
      isSharing.value = false;
      Get.snackbar(
        "Error", 
        "Could not share profile image",
        backgroundColor: Colors.redAccent.withOpacity(0.7),
        colorText: Colors.white
      );
    }
  }
}
