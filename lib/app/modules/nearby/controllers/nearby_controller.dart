import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import '../../edit_profile/controllers/edit_profile_controller.dart';

class NearbyDevice {
  final String name;
  final String ip;
  final String deviceId;

  NearbyDevice({required this.name, required this.ip, required this.deviceId});

  @override
  bool operator ==(Object other) => other is NearbyDevice && other.ip == ip;

  @override
  int get hashCode => ip.hashCode;
}

class NearbyController extends GetxController {
  var devices = <NearbyDevice>{}.obs; 
  RawDatagramSocket? _udpSocket;
  final int udpPort = 53353;
  final int httpPort = 53354;
  Timer? _discoveryTimer;

  @override
  void onInit() {
    super.onInit();
    startDiscovery();
  }

  void startDiscovery() async {
    devices.clear();
    try {
      _udpSocket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, udpPort);
      _udpSocket?.broadcastEnabled = true;
      
      _udpSocket?.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          Datagram? dg = _udpSocket?.receive();
          if (dg != null) {
            String message = utf8.decode(dg.data);
            if (message.startsWith("VLAGIT_DISCOVERY:")) {
              var parts = message.split(":");
              if (parts.length >= 3) {
                String name = parts[1];
                String id = parts[2];
                // basic check to avoid adding itself if we had a unique ID, 
                // for now we just add based on IP
                devices.add(NearbyDevice(name: name, ip: dg.address.address, deviceId: id));
              }
            }
          }
        }
      });

      // Broadcast presence every 3 seconds
      _discoveryTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        broadcastPresence();
      });
    } catch (e) {
      print("Discovery Error: $e");
    }
  }

  void broadcastPresence() {
    final editCtrl = Get.find<EditProfileController>();
    String myName = editCtrl.fullNameController.text.isEmpty ? "Anonymous" : editCtrl.fullNameController.text;
    String message = "VLAGIT_DISCOVERY:$myName:DEVICE_${Platform.operatingSystem}";
    _udpSocket?.send(utf8.encode(message), InternetAddress("255.255.255.255"), udpPort);
  }

  Future<void> sendDataToDevice(NearbyDevice device) async {
    final editCtrl = Get.find<EditProfileController>();
    
    Map<String, dynamic> data = {
      'fullName': editCtrl.fullNameController.text,
      'title': editCtrl.titleController.text,
      'note': editCtrl.noteController.text,
      'email': editCtrl.emailController.text,
      'website': editCtrl.websiteController.text,
      'phone': editCtrl.phoneController.text,
      'social': editCtrl.socialController.text,
      'social2': editCtrl.social2Controller.text,
      'isEmailActive': editCtrl.isEmailActive.value,
      'isWebsiteActive': editCtrl.isWebsiteActive.value,
      'isPhoneActive': editCtrl.isPhoneActive.value,
      'isSocialActive': editCtrl.isSocialActive.value,
      'isSocial2Active': editCtrl.isSocial2Active.value,
    };

    try {
      var client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 5);
      HttpClientRequest request = await client.post(device.ip, httpPort, '/receive');
      request.headers.contentType = ContentType.json;
      request.add(utf8.encode(jsonEncode(data)));
      await request.close();
      Get.snackbar("Success", "Profile sent to ${device.name}", snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Failed to send: $e", snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    _discoveryTimer?.cancel();
    _udpSocket?.close();
    super.onClose();
  }
}
