import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceiveController extends GetxController {
  final storage = GetStorage();
  HttpServer? _server;
  final int httpPort = 53354;
  var receivedList = <Map<String, dynamic>>[].obs;

  // Ad variables
  RewardedAd? _rewardedAd;
  bool isAdLoaded = false;

  @override
  void onInit() {
    super.onInit();
    loadReceivedProfiles();
    startServer();
    _loadRewardedAd();
  }

  void loadReceivedProfiles() {
    List? storedList = storage.read<List>('receivedProfiles');
    if (storedList != null) {
      receivedList.assignAll(storedList.map((e) => Map<String, dynamic>.from(e)).toList());
    }
  }

  void saveToStorage() {
    storage.write('receivedProfiles', receivedList.toList());
  }

  void deleteProfile(int index) {
    receivedList.removeAt(index);
    saveToStorage();
    Get.snackbar(
      "Deleted", 
      "Profile removed from your list",
      backgroundColor: Colors.redAccent.withOpacity(0.7),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1),
    );
  }

  void _loadRewardedAd() {
    String adUnitId = dotenv.get('ADMOB_REWARDED_UNIT_ID');
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          isAdLoaded = true;
        },
        onAdFailedToLoad: (error) {
          isAdLoaded = false;
          _rewardedAd = null;
        },
      ),
    );
  }

  void showAdAndOpenProfile(Map<String, dynamic> profile) {
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
            Text("Unlock Profile", style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            Text("Watch a short ad to view the full profile details.", 
              textAlign: TextAlign.center, style: TextStyle(color: Colors.white60, fontSize: 14.sp)),
            SizedBox(height: 25.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC3A0FF),
                minimumSize: Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
              ),
              onPressed: () {
                Get.back(); // Close bottom sheet
                if (isAdLoaded && _rewardedAd != null) {
                  _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
                    onAdDismissedFullScreenContent: (ad) {
                      ad.dispose();
                      isAdLoaded = false;
                      _loadRewardedAd();
                      Get.toNamed('/receive-profile', arguments: profile);
                    },
                    onAdFailedToShowFullScreenContent: (ad, error) {
                      ad.dispose();
                      isAdLoaded = false;
                      _loadRewardedAd();
                      Get.toNamed('/receive-profile', arguments: profile);
                    },
                  );
                  _rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
                    // Reward handled in onAdDismissed
                  });
                } else {
                  // Fallback if ad not ready
                  Get.toNamed('/receive-profile', arguments: profile);
                  _loadRewardedAd();
                }
              },
              child: Text("Watch Ad to View", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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

  void startServer() async {
    try {
      _server = await HttpServer.bind(InternetAddress.anyIPv4, httpPort);
      _server?.listen((HttpRequest request) async {
        if (request.uri.path == '/receive' && request.method == 'POST') {
          String content = await utf8.decoder.bind(request).join();
          var data = jsonDecode(content);
          
          // Use fullName or phone as a unique identifier to avoid duplicates
          String identifier = data['fullName'] ?? 'Unknown';
          
          int existingIndex = receivedList.indexWhere((item) => item['fullName'] == identifier);
          
          if (existingIndex != -1) {
            // Update existing entry
            receivedList[existingIndex] = Map<String, dynamic>.from(data);
          } else {
            // Add new data to the beginning of the list
            receivedList.insert(0, Map<String, dynamic>.from(data));
          }
          
          saveToStorage(); // Save to storage permanently
          
          request.response.statusCode = HttpStatus.ok;
          request.response.write("OK");
          await request.response.close();
        }
      });
    } catch (e) {
      print("Server Error: $e");
    }
  }

  @override
  void onClose() {
    _server?.close();
    super.onClose();
  }
}
