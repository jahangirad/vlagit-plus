import 'dart:convert';
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

    // Image to Base64 for QR - Optimized for QR stability
    String? base64Image;
    if (imagePath.value.isNotEmpty) {
      try {
        final File imageFile = File(imagePath.value);
        final bytes = await imageFile.readAsBytes();
        
        // Check if bytes size is acceptable for QR (roughly < 1.5 KB to keep total payload small)
        if (bytes.length > 2048) {
           print("Warning: Image too large for QR (${bytes.length} bytes). Scanner might fail.");
        }
        
        base64Image = base64Encode(bytes);
      } catch (e) {
        print("Error encoding image: $e");
      }
    }

    // Generate Optimized JSON for QR (only include active fields to save space)
    Map<String, dynamic> profileMap = {
      'fullName': fullNameController.text,
      'title': titleController.text,
    };
    
    if (noteController.text.isNotEmpty) profileMap['note'] = noteController.text;
    if (isEmailActive.value) profileMap['email'] = emailController.text;
    if (isWebsiteActive.value) profileMap['website'] = websiteController.text;
    if (isPhoneActive.value) profileMap['phone'] = phoneController.text;
    if (isSocialActive.value) profileMap['social'] = socialController.text;
    if (isSocial2Active.value) profileMap['social2'] = social2Controller.text;
    
    // Include flags for UI consistency in Receiver
    profileMap['isEmailActive'] = isEmailActive.value;
    profileMap['isWebsiteActive'] = isWebsiteActive.value;
    profileMap['isPhoneActive'] = isPhoneActive.value;
    profileMap['isSocialActive'] = isSocialActive.value;
    profileMap['isSocial2Active'] = isSocial2Active.value;

    // IMPORTANT: We do NOT include the profileImage in the QR code because 
    // it makes the QR data too large to render or scan.
    // The image is shared via the "Nearby" feature instead.
    
    String qrData = jsonEncode(profileMap);
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
