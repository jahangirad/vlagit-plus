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
    controller.refreshData();
    final ScreenshotController screenshotController = controller.screenshotController;

    // Pre-cache brand assets to ensure they are ready for screenshot
    precacheImage(const AssetImage('assets/icon/icon.png'), context);
    precacheImage(const AssetImage('assets/play-store.png'), context);
    precacheImage(const AssetImage('assets/apple-store.png'), context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E0044), Colors.black],
            stops: [0.0, 0.5],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 100.h),
              
              Screenshot(
                controller: screenshotController,
                child: Container(
                  width: 340.w,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF2A005E),
                        Color(0xFF120030),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(55.r),
                    border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6200EE).withOpacity(0.3),
                        blurRadius: 40,
                        offset: const Offset(0, 15),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildProfileCard(context),
                      
                      // Condition-based rendering to keep the card compact when not sharing
                      Obx(() => controller.isSharing.value 
                        ? _buildShareFooter() 
                        : SizedBox(height: 25.h)),
                    ],
                  ),
                ),
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
            style: TextStyle(color: Colors.white, fontSize: 30.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6.h),
          Text(
            controller.title.value,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white60, fontSize: 16.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 40.h),
          Container(
            width: 190.w,
            height: 190.w,
            padding: EdgeInsets.all(18.r),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40.r)),
            child: QrImageView(
              data: controller.qrContent.value,
              version: QrVersions.auto,
              size: 150.0,
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildShareFooter() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
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
              Image.asset(
                'assets/icon/icon.png',
                height: 35.h,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 12.w),
              Text(
                "VLAGIT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: _buildStoreButton('assets/play-store.png')),
              SizedBox(width: 15.w),
              Expanded(child: _buildStoreButton('assets/apple-store.png')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoreButton(String imagePath) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.2),
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}
