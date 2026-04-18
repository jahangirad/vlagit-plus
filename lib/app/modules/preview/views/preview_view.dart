import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controllers/preview_controller.dart';

class PreviewView extends GetView<PreviewController> {
  const PreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    // Refresh data whenever the view is built
    controller.refreshData();
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E0044),
              Colors.black,
            ],
            stops: [0.0, 0.5],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 80.h),
              Obx(() => Container(
                    width: 340.w,
                    padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 20.w),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF150035),
                          Color(0xFF050010),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(55.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              padding: EdgeInsets.all(3.r),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF00E5FF),
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00E5FF).withOpacity(0.4),
                                    blurRadius: 15,
                                    spreadRadius: 2,
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
                                decoration: const BoxDecoration(
                                  color: Color(0xFF00E5FF),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.verified,
                                  size: 18.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),
                        Text(
                          controller.fullName.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          controller.title.value,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        Container(
                          width: 190.w,
                          height: 190.w,
                          padding: EdgeInsets.all(18.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                          child: QrImageView(
                            data: controller.qrContent.value,
                            version: QrVersions.auto,
                            size: 150.0,
                          ),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  )),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
