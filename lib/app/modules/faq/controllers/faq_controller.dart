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
      'answer': 'Profile sharing via local network and QR works without internet, but you will need a connection to load advertisements for unlocking profiles.'
    },
  ].obs;
}
