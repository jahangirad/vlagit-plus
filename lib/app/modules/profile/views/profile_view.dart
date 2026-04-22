import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                _buildSettingItem(
                  icon: Icons.help_outline_rounded,
                  title: "FAQ",
                  subtitle: "Commonly asked questions",
                  onTap: () => Get.toNamed(Routes.FAQ),
                ),
                SizedBox(height: 10.h),
                _buildSettingItem(
                  icon: Icons.alternate_email_rounded,
                  title: "Contact Us",
                  subtitle: "Get in touch with our team",
                  onTap: () => Get.toNamed(Routes.CONTACT_US),
                ),

                SizedBox(height: 120.h),

                // 4. Version Info
                Center(
                  child: Text(
                    "VERSION 1.0.0 (VLAGIT)",
                    style: TextStyle(
                      color: Colors.white24,
                      fontSize: 11.sp,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // Setting Item Helper
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(18.r),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D).withOpacity(0.6),
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundColor: const Color(0xFF1A1A1A),
              child: Icon(icon, color: const Color(0xFF00E5FF), size: 24.sp),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing,
            SizedBox(width: 10.w),
            Icon(Icons.arrow_forward_ios_rounded, color: const Color(0xFF4DB6AC), size: 14.sp),
          ],
        ),
      ),
    );
  }
}
