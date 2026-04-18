import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'button_widget.dart';

class CustomBottomSheet {
  static void showUnlockProfile() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 25.h),

            Text(
              "Choose how you want to see who's\nchecking you out",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 30.h),

            // Watch Video Ad Button
            CustomButton(
              text: "Watch Ad & Continue",
              icon: Icons.play_circle_fill,
              onPressed: () {
                Get.back();
              },
            ),
            SizedBox(height: 20.h),

            // Footer Text
            Text(
              "By choosing an option, you agree to our terms of service. Free\nunlocks are limited to 3 per day.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white24,
                fontSize: 10.sp,
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
