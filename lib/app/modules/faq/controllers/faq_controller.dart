import 'package:get/get.dart';

class FaqController extends GetxController {
  final faqs = [
    {
      'question': 'How do I share my profile?',
      'answer': 'You can share your profile via QR code or by using the "Nearby" feature to send it to devices on the same local network.'
    },
    {
      'question': 'Is my data secure?',
      'answer': 'Yes, your profile data is shared directly over your local network or via QR code. We do not store your personal details on any external servers.'
    },
    {
      'question': 'How do I unlock a received profile?',
      'answer': 'To view the full details of a profile received via the local network, you simply need to watch a short rewarded advertisement.'
    },
    {
      'question': 'Can I use Vlagit without internet?',
      'answer': 'Vlagit is fully offline operation - transfer profile over local Wi-Fi or LAN, no internet required. \nEnd-to-end TLS encryption - full confidentiality and integrity of your data Cross-platform compatibility - available on iOS and Android. \nNo tracking, no data collection.'
    },
  ].obs;
}
