import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../home/controllers/home_controller.dart';

class QrCodeController extends GetxController {
  final storage = GetStorage();
  final HomeController homeController = Get.find<HomeController>();
  final MobileScannerController scannerController = MobileScannerController(
    autoStart: false,
  );

  // Generate a clean text payload for QR from stored data
  String generatePayload() {
    String name = storage.read('fullName') ?? "";
    String title = storage.read('title') ?? "";
    String email = storage.read('email') ?? "";
    String phone = storage.read('phone') ?? "";
    String web = storage.read('website') ?? "";
    String social = storage.read('social') ?? "";
    String social2 = storage.read('social2') ?? "";
    String note = storage.read('note') ?? "";

    bool isEmailActive = storage.read('isEmailActive') ?? false;
    bool isWebActive = storage.read('isWebsiteActive') ?? false;
    bool isPhoneActive = storage.read('isPhoneActive') ?? false;
    bool isSocialActive = storage.read('isSocialActive') ?? false;
    bool isSocial2Active = storage.read('isSocial2Active') ?? false;

    StringBuffer sb = StringBuffer();
    sb.writeln("--- VLAGIT PROFILE ---");
    if (name.isNotEmpty) sb.writeln("Name: $name");
    if (title.isNotEmpty) sb.writeln("Title: $title");
    if (note.isNotEmpty) sb.writeln("Note: $note");
    if (isEmailActive && email.isNotEmpty) sb.writeln("Email: $email");
    if (isPhoneActive && phone.isNotEmpty) sb.writeln("Phone: $phone");
    if (isWebActive && web.isNotEmpty) sb.writeln("Web: $web");
    if (isSocialActive && social.isNotEmpty) sb.writeln("Social 1: $social");
    if (isSocial2Active && social2.isNotEmpty) sb.writeln("Social 2: $social2");

    return sb.toString();
  }

  void onScanSuccess(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;
      if (code != null) {
        scannerController.stop();
        _showResultDialog(code);
      }
    }
  }

  void _showResultDialog(String data) {
    // Parse the data lines for better UI
    List<String> lines = data.split('\n').where((line) => line.trim().isNotEmpty && !line.contains('---')).toList();

    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0D0D0D).withOpacity(0.9),
              borderRadius: BorderRadius.circular(35.r),
              border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.2), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00E5FF).withOpacity(0.15),
                  blurRadius: 30,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.fromLTRB(25.w, 25.h, 15.w, 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00E5FF).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.qr_code_scanner_rounded, color: const Color(0xFF00E5FF), size: 20.sp),
                          ),
                          SizedBox(width: 15.w),
                          Text(
                            "SCANNED PROFILE",
                            style: TextStyle(
                              color: const Color(0xFF00E5FF),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                          Get.back();
                          homeController.changePage(2);
                        },
                        icon: Icon(Icons.close_rounded, color: Colors.white24, size: 24.sp),
                      ),
                    ],
                  ),
                ),

                const Divider(color: Colors.white10),

                // Data Content Area
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                    child: Column(
                      children: lines.map((line) {
                        // Split by first colon to separate Label and Value
                        int colonIndex = line.indexOf(':');
                        if (colonIndex != -1) {
                          String label = line.substring(0, colonIndex).trim();
                          String value = line.substring(colonIndex + 1).trim();
                          
                          return Padding(
                            padding: EdgeInsets.only(bottom: 15.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 70.w,
                                  child: Text(
                                    label,
                                    style: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SelectableText(
                                    value,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontFamily: 'SourceSerif4',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // For lines without colon (like Note body)
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: SelectableText(
                              line,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13.sp,
                                fontFamily: 'SourceSerif4',
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          );
                        }
                      }).toList(),
                    ),
                  ),
                ),

                // Action Footer
                Padding(
                  padding: EdgeInsets.all(25.r),
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC3A0FF),
                          foregroundColor: Colors.black,
                          minimumSize: Size(double.infinity, 55.h),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
                        ),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: data));
                          Get.snackbar(
                            "COPIED",
                            "Information saved to clipboard",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: const Color(0xFFC3A0FF),
                            colorText: Colors.black,
                            margin: EdgeInsets.all(20.r),
                            borderRadius: 15.r,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.copy_all_rounded, size: 22.sp),
                            SizedBox(width: 12.w),
                            Text("COPY INFORMATION", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w900, letterSpacing: 1)),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                          scannerController.start();
                        },
                        child: Text(
                          "SCAN ANOTHER PROFILE",
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 400), () {
      scannerController.start();
    });
  }

  @override
  void onClose() {
    scannerController.stop();
    scannerController.dispose();
    super.onClose();
  }
}
