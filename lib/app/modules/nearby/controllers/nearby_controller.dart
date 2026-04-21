import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:collection/collection.dart'; // Added for firstWhereOrNull
import '../../edit_profile/controllers/edit_profile_controller.dart';

class NearbyDevice {
  final String name;
  final String ip;
  final String deviceId;
  final String? base64Image;
  DateTime lastSeen; // Track when the device was last seen

  NearbyDevice({
    required this.name, 
    required this.ip, 
    required this.deviceId, 
    this.base64Image, 
    required this.lastSeen,
  });

  @override
  bool operator ==(Object other) => other is NearbyDevice && other.deviceId == deviceId;

  @override
  int get hashCode => deviceId.hashCode;
}

class NearbyController extends GetxController {
  var devices = <NearbyDevice>{}.obs; 
  RawDatagramSocket? _udpSocket;
  final int udpPort = 53353;
  final int httpPort = 53354;
  Timer? _discoveryTimer;
  Timer? _cleanupTimer;
  
  // Ad variables
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;
  
  // Unique ID for this device session to avoid discovering itself
  final String _myId = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void onInit() {
    super.onInit();
    startDiscovery();
    _loadRewardedAd();
    _startCleanupTimer();
  }

  void _loadRewardedAd() {
    String adUnitId = dotenv.get('ADMOB_REWARDED_UNIT_ID');
    
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          _isAdLoaded = true;
          print("Ad Loaded Successfully");
        },
        onAdFailedToLoad: (error) {
          _isAdLoaded = false;
          _rewardedAd = null;
          print("Ad Failed to Load: $error");
        },
      ),
    );
  }

  void _startCleanupTimer() {
    // Every 10 seconds, remove devices that haven't been seen for 10 seconds
    _cleanupTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      final now = DateTime.now();
      devices.removeWhere((device) => now.difference(device.lastSeen).inSeconds > 10);
      devices.refresh();
    });
  }

  void refreshDiscovery() {
    devices.clear();
    broadcastPresence();
  }

  void startDiscovery() async {
    try {
      _udpSocket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, udpPort);
      _udpSocket?.broadcastEnabled = true;
      _udpSocket?.multicastLoopback = false;
      
      _udpSocket?.listen((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          Datagram? dg = _udpSocket?.receive();
          if (dg != null) {
            String message = utf8.decode(dg.data);
            
            if (message.startsWith("VLAGIT_DISCOVERY:")) {
              var parts = message.split("|");
              if (parts.length >= 3) {
                String name = parts[1];
                String id = parts[2];
                String? img = parts.length > 3 ? parts[3] : null;
                
                if (id != _myId) {
                  // If device exists, update lastSeen, else add new
                  var existing = devices.firstWhereOrNull((d) => d.deviceId == id);
                  if (existing != null) {
                    existing.lastSeen = DateTime.now();
                    devices.refresh();
                  } else {
                    devices.add(NearbyDevice(
                      name: name, 
                      ip: dg.address.address, 
                      deviceId: id, 
                      base64Image: img,
                      lastSeen: DateTime.now(),
                    ));
                  }
                }
              }
            }
          }
        }
      });

      _discoveryTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        broadcastPresence();
      });
    } catch (e) {
      print("Discovery Error: $e");
    }
  }

  void broadcastPresence() async {
    try {
      final editCtrl = Get.find<EditProfileController>();
      String myName = editCtrl.fullNameController.text.isEmpty ? "Anonymous" : editCtrl.fullNameController.text;
      
      // We'll send name and ID. We won't send the full image via UDP as it's too large,
      // but we could send a small thumbnail if needed. For now, let's just fix the discovery.
      String message = "VLAGIT_DISCOVERY:|$myName|$_myId";
      
      print("Broadcasting presence: $message");
      
      // Send to general broadcast address
      _udpSocket?.send(utf8.encode(message), InternetAddress("255.255.255.255"), udpPort);
      
      // Also try to send to subnet broadcast for all network interfaces
      // This helps on some routers that block 255.255.255.255
      try {
        var interfaces = await NetworkInterface.list();
        for (var interface in interfaces) {
          for (var addr in interface.addresses) {
            if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
              String ip = addr.address;
              String subnet = ip.substring(0, ip.lastIndexOf('.'));
              _udpSocket?.send(utf8.encode(message), InternetAddress("$subnet.255"), udpPort);
            }
          }
        }
      } catch (e) {
        // Ignore interface listing errors
      }
    } catch (e) {
      print("Broadcast Error: $e");
    }
  }

  Future<void> sendDataToDevice(NearbyDevice device) async {
    final storage = GetStorage();
    final now = DateTime.now();
    
    // Check send limits (Max 5 in 24 hours)
    List sendHistory = storage.read('sendHistory') ?? [];
    // Filter history to keep only last 24 hours
    sendHistory = sendHistory.where((time) => 
      now.difference(DateTime.parse(time)).inHours < 24
    ).toList();
    
    if (sendHistory.length >= 5) {
      // Show bottom sheet for Ad
      _showAdBottomSheet(() async {
        await _performSendData(device);
        // Record the send action
        sendHistory.add(now.toIso8601String());
        storage.write('sendHistory', sendHistory);
      });
    } else {
      await _performSendData(device);
      // Record the send action
      sendHistory.add(now.toIso8601String());
      storage.write('sendHistory', sendHistory);
    }
  }

  Future<void> _performSendData(NearbyDevice device) async {
    final editCtrl = Get.find<EditProfileController>();
    
    // Convert image to Base64 if exists
    String? base64Image;
    if (editCtrl.imagePath.value.isNotEmpty) {
      final bytes = await File(editCtrl.imagePath.value).readAsBytes();
      base64Image = base64Encode(bytes);
    }

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
      'profileImage': base64Image, // Added image
    };

    try {
      var client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 10);
      HttpClientRequest request = await client.post(device.ip, httpPort, '/receive');
      request.headers.contentType = ContentType.json;
      request.add(utf8.encode(jsonEncode(data)));
      await request.close();
      Get.snackbar("Success", "Profile sent to ${device.name}", snackPosition: SnackPosition.TOP, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Failed to send: $e", snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  void _showAdBottomSheet(VoidCallback onAdComplete) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Limit Reached", style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            Text("Watch a short ad to continue sharing!", 
              textAlign: TextAlign.center, style: TextStyle(color: Colors.white60, fontSize: 14.sp)),
            SizedBox(height: 25.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC3A0FF),
                minimumSize: Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
              ),
              onPressed: () {
                Get.back();
                if (_isAdLoaded && _rewardedAd != null) {
                  _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
                    onAdDismissedFullScreenContent: (ad) {
                      ad.dispose();
                      _isAdLoaded = false;
                      _loadRewardedAd();
                    },
                    onAdFailedToShowFullScreenContent: (ad, error) {
                      ad.dispose();
                      _isAdLoaded = false;
                      _loadRewardedAd();
                      onAdComplete();
                    },
                  );
                  _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
                    onAdComplete();
                  });
                } else {
                  Get.snackbar("Notice", "Ad not ready, allowing send once.", 
                    snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.orange, colorText: Colors.white);
                  onAdComplete();
                  _loadRewardedAd();
                }
              },
              child: Text("Watch Ad & Continue", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel", style: TextStyle(color: Colors.white38)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onClose() {
    _discoveryTimer?.cancel();
    _cleanupTimer?.cancel(); // Added cleanup timer cancel
    _udpSocket?.close();
    _rewardedAd?.dispose();
    super.onClose();
  }
}
