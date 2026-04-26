import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'button_widget.dart';

class CustomBottomSheet {
  static void showAdUnlock({
    required String title,
    required String description,
    required VoidCallback onAdClick,
    String buttonText = "Watch Ad & Continue",
  }) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(25.r),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(35.r)),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF00E5FF),
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 35.h),
            CustomButton(
              text: buttonText,
              onPressed: onAdClick,
            ),
            SizedBox(height: 10.h),
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
