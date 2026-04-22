import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../controllers/preview_controller.dart';

class PreviewView extends GetView<PreviewController> {
  const PreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    // controller.refreshData(); // Remove this from here to avoid the error
    final ScreenshotController screenshotController = controller.screenshotController;

    // Use Future.microtask or addPostFrameCallback to refresh data safely after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.refreshData();
    });

    // Pre-cache brand assets to ensure they are ready for screenshot
    precacheImage(const AssetImage('assets/icon/icon.png'), context);
    precacheImage(const AssetImage('assets/play-store.png'), context);
    precacheImage(const AssetImage('assets/apple-store.png'), context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              
              Screenshot(
                controller: screenshotController,
                child: Obx(() => Container(
                  width: 340.w,
                  decoration: BoxDecoration(
                    gradient: controller.isSharing.value 
                      ? const RadialGradient(
                          center: Alignment(0, -0.5),
                          radius: 1.5,
                          colors: [
                            Color(0xFF0A0F1E),
                            Color(0xFF000000),
                          ],
                        )
                      : null,
                    borderRadius: controller.isSharing.value ? BorderRadius.circular(55.r) : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildProfileCard(context),
                      
                      // Condition-based rendering to keep the card compact when not sharing
                      if (controller.isSharing.value) _buildShareFooter() else SizedBox(height: 25.h),
                    ],
                  ),
                )),
              ),
              
              SizedBox(height: 120.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Obx(() => Padding(
      padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 20.w),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF00E5FF), width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00E5FF).withOpacity(0.4),
                      blurRadius: 15,
                    )
                  ],
                ),
                child: CircleAvatar(
                  radius: 65.r,
                  backgroundColor: Colors.grey[900],
                  backgroundImage: controller.imagePath.value.isNotEmpty
                      ? FileImage(File(controller.imagePath.value))
                      : null,
                  child: controller.imagePath.value.isEmpty
                      ? Icon(Icons.person, size: 65.sp, color: Colors.white24)
                      : null,
                ),
              ),
              Positioned(
                right: 8.w,
                bottom: 5.h,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(color: Color(0xFF00E5FF), shape: BoxShape.circle),
                  child: Icon(Icons.verified, size: 18.sp, color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(height: 25.h),
          Text(
            controller.fullName.value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontSize: 30.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6.h),
          Text(
            controller.title.value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white60, fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 40.h),
          Container(
            width: 220.w,
            height: 220.w,
            padding: EdgeInsets.all(12.r), // Reduced padding for larger QR
            decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ]
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                QrImageView(
                  data: controller.qrContent.value.isEmpty ? "No Data" : controller.qrContent.value,
                  version: QrVersions.auto,
                  errorCorrectionLevel: QrErrorCorrectLevel.M, // Changed to M for better scannability with logo
                  size: 220.0,
                  gapless: false,
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: Colors.black,
                  ),
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: Colors.black,
                  ),
                ),
                // Smaller Center Round Logo
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 34.w,
                      height: 34.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/icon/icon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildShareFooter() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF050010),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(55.r)),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with rounded background like in image
              Container(
                height: 32.h,
                width: 32.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B3022), // Subtle dark green background
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.all(5.r),
                child: Image.asset(
                  'assets/icon/icon.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 15.w),
              Text(
                "VLAGIT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                ),
              ),
            ],
          ),
          SizedBox(height: 35.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStoreButton('assets/play-store.png'),
              SizedBox(width: 15.w),
              _buildStoreButton('assets/apple-store.png'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoreButton(String imagePath) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      height: 48.h, 
      width: 140.w,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.2),
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}
