import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final storage = GetStorage();
  
  var fullName = ''.obs;
  var title = ''.obs;
  var imagePath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    fullName.value = storage.read('fullName') ?? 'Your Name';
    title.value = storage.read('title') ?? 'Vlagit Plus User';
    imagePath.value = storage.read('imagePath') ?? '';
  }
}
