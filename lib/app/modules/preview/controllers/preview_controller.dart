import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PreviewController extends GetxController {
  final storage = GetStorage();

  var fullName = ''.obs;
  var title = ''.obs;
  var note = ''.obs;
  var imagePath = ''.obs;
  var qrContent = 'Vlagit Plus'.obs;

  @override
  void onInit() {
    super.onInit();
    loadPreviewData();
  }

  void loadPreviewData() {
    fullName.value = storage.read('fullName') ?? 'Elena Vance';
    title.value = storage.read('title') ?? 'Digital Architect';
    note.value = storage.read('note') ?? '';
    imagePath.value = storage.read('imagePath') ?? '';
    qrContent.value = storage.read('qrContent') ?? 'Vlagit Plus';
  }
  
  // Refresh data when the view is shown (if needed)
  void refreshData() => loadPreviewData();
}
