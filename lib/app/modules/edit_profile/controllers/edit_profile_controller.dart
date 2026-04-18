import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
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
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
    }
  }

  void saveProfile() {
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

    // Generate QR Data string
    List<String> qrLines = [];
    
    // Always add these if not empty
    if (fullNameController.text.trim().isNotEmpty) qrLines.add("Name: ${fullNameController.text.trim()}");
    if (titleController.text.trim().isNotEmpty) qrLines.add("Title: ${titleController.text.trim()}");
    if (noteController.text.trim().isNotEmpty) qrLines.add("Note: ${noteController.text.trim()}");

    // Add these only if Switch is ON and Field is NOT EMPTY
    if (isEmailActive.value && emailController.text.trim().isNotEmpty) {
      qrLines.add("Email: ${emailController.text.trim()}");
    }
    if (isWebsiteActive.value && websiteController.text.trim().isNotEmpty) {
      qrLines.add("Website: ${websiteController.text.trim()}");
    }
    if (isPhoneActive.value && phoneController.text.trim().isNotEmpty) {
      qrLines.add("Phone: ${phoneController.text.trim()}");
    }
    if (isSocialActive.value && socialController.text.trim().isNotEmpty) {
      qrLines.add("Social 1: ${socialController.text.trim()}");
    }
    if (isSocial2Active.value && social2Controller.text.trim().isNotEmpty) {
      qrLines.add("Social 2: ${social2Controller.text.trim()}");
    }

    String qrData = qrLines.isNotEmpty ? qrLines.join("\n") : "No profile information shared.";
    storage.write('qrContent', qrData);

    // Update PreviewController in real-time
    if (Get.isRegistered<PreviewController>()) {
      Get.find<PreviewController>().loadPreviewData();
    }

    Get.snackbar(
      "Success", 
      "Profile and QR Code updated!",
      backgroundColor: Colors.green.withOpacity(0.7), 
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM
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
