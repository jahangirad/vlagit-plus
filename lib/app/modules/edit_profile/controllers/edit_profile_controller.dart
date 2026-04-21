import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vlagit_plus/app/modules/qr_code/controllers/qr_code_controller.dart';
import '../../preview/controllers/preview_controller.dart';

class EditProfileController extends GetxController {
  final storage = GetStorage();
  final picker = ImagePicker();

  // Observable variables
  var imagePath = ''.obs;
  
  // Text Controllers
  final fullNameController = TextEditingController();
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final phoneController = TextEditingController();
  final socialController = TextEditingController();
  final social2Controller = TextEditingController();

  // Switch states
  var isEmailActive = false.obs;
  var isWebsiteActive = false.obs;
  var isPhoneActive = false.obs;
  var isSocialActive = false.obs;
  var isSocial2Active = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 200, // Optimized for QR code & mobile display
      maxHeight: 200,
      imageQuality: 70, // Balanced quality and size
    );
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  void saveProfile() async {
    // Save text fields
    storage.write('fullName', fullNameController.text);
    storage.write('title', titleController.text);
    storage.write('note', noteController.text);
    storage.write('email', emailController.text);
    storage.write('website', websiteController.text);
    storage.write('phone', phoneController.text);
    storage.write('social', socialController.text);
    storage.write('social2', social2Controller.text);
    storage.write('imagePath', imagePath.value);

    // Save switches
    storage.write('isEmailActive', isEmailActive.value);
    storage.write('isWebsiteActive', isWebsiteActive.value);
    storage.write('isPhoneActive', isPhoneActive.value);
    storage.write('isSocialActive', isSocialActive.value);
    storage.write('isSocial2Active', isSocial2Active.value);

    // Create Clean Text Payload for QR
    StringBuffer sb = StringBuffer();
    sb.writeln("--- VLAGIT PROFILE ---");
    if (fullNameController.text.isNotEmpty) sb.writeln("Name: ${fullNameController.text}");
    if (titleController.text.isNotEmpty) sb.writeln("Title: ${titleController.text}");
    if (noteController.text.isNotEmpty) sb.writeln("Note: ${noteController.text}");
    
    if (isEmailActive.value && emailController.text.isNotEmpty) sb.writeln("Email: ${emailController.text}");
    if (isPhoneActive.value && phoneController.text.isNotEmpty) sb.writeln("Phone: ${phoneController.text}");
    if (isWebsiteActive.value && websiteController.text.isNotEmpty) sb.writeln("Web: ${websiteController.text}");
    if (isSocialActive.value && socialController.text.isNotEmpty) sb.writeln("Social 1: ${socialController.text}");
    if (isSocial2Active.value && social2Controller.text.isNotEmpty) sb.writeln("Social 2: ${social2Controller.text}");
    
    // Save the clean text to 'qrContent'
    storage.write('qrContent', sb.toString());

    // Update Controllers in real-time
    if (Get.isRegistered<PreviewController>()) {
      Get.find<PreviewController>().loadPreviewData();
    }
    if (Get.isRegistered<QrCodeController>()) {
      // Regenerate the clean text QR
      Get.find<QrCodeController>().update();
    }

    Get.snackbar(
      "Success", 
      "Profile and QR Code updated!",
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP
    );
  }

  void loadUserData() {
    fullNameController.text = storage.read('fullName') ?? '';
    titleController.text = storage.read('title') ?? '';
    noteController.text = storage.read('note') ?? '';
    emailController.text = storage.read('email') ?? '';
    websiteController.text = storage.read('website') ?? '';
    phoneController.text = storage.read('phone') ?? '';
    socialController.text = storage.read('social') ?? '';
    social2Controller.text = storage.read('social2') ?? '';
    imagePath.value = storage.read('imagePath') ?? '';

    isEmailActive.value = storage.read('isEmailActive') ?? false;
    isWebsiteActive.value = storage.read('isWebsiteActive') ?? false;
    isPhoneActive.value = storage.read('isPhoneActive') ?? false;
    isSocialActive.value = storage.read('isSocialActive') ?? false;
    isSocial2Active.value = storage.read('isSocial2Active') ?? false;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    titleController.dispose();
    noteController.dispose();
    emailController.dispose();
    websiteController.dispose();
    phoneController.dispose();
    socialController.dispose();
    social2Controller.dispose();
    super.onClose();
  }
}
