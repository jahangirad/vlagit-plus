import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../controllers/qr_code_controller.dart';

class QrCodeView extends GetView<QrCodeController> {
  const QrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Scan QR Code",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Full screen scanner
          MobileScanner(
            controller: controller.scannerController,
            onDetect: controller.onScanSuccess,
          ),

          // স্ক্যানিং ওভারলে (ডার্ক মাস্ক এবং মাঝখানে স্বচ্ছ ফ্রেম)
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Center(
                  child: Container(
                    height: 260.w,
                    width: 260.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ফ্রেমের বর্ডার এবং কোনাগুলো
          Center(
            child: Container(
              height: 260.w,
              width: 260.w,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF00E5FF), width: 3),
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ),

          // নিচের টেক্সট গাইড
          Positioned(
            bottom: 120.h,
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                "Align the QR code within the frame to scan",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // ফ্ল্যাশলাইট বাটন (অপশনাল)
          Positioned(
            bottom: 50.h,
            right: 30.w,
            child: CircleAvatar(
              backgroundColor: Colors.white10,
              radius: 25.r,
              child: IconButton(
                icon: const Icon(Icons.flash_on, color: Colors.white),
                onPressed: () => controller.scannerController.toggleTorch(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}