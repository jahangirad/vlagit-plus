import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsController extends GetxController {
  Future<void> launchEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'support@vlagit.com',
      query: 'subject=Support Request&body=Hi Vlagit Team,',
    );
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    }
  }

  Future<void> launchWebsite() async {
    final Uri url = Uri.parse('https://www.vlagit.com');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> launchTelegram() async {
    final Uri url = Uri.parse('https://t.me/vlagitofficial');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
