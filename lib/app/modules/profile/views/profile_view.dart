import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vlagit_plus/app/routes/app_pages.dart';
import '../../../global_widgets/appbar_widget.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: "Settings",
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios,
                color: const Color(0xFFc799ff), size: 22.sp)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E0044), // Top purple glow
              Colors.black,
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                // 1. Profile Header Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(25.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D0D0D).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(45.r),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    children: [
                      // Profile Image with Verified Badge
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50.r,
                            backgroundColor: Colors.grey[900],
                            backgroundImage: const NetworkImage(
                              'https://img.freepik.com/free-photo/view-3d-man-holding-hands-pockets_23-2150709923.jpg',
                            ),
                          ),
                          Positioned(
                            right: 2.w,
                            bottom: 2.h,
                            child: Container(
                              padding: EdgeInsets.all(2.r),
                              decoration: const BoxDecoration(
                                color: Color(0xFF00E5FF),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.check,
                                  size: 14.sp, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alex Rivera",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "Vlagit Plus • Active",
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 14.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                // 2. General Settings Section
                _buildSectionTitle("GENERAL SETTINGS"),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.EDIT_PROFILE);
                  },
                  child: _buildSettingItem(
                    icon: Icons.person_outline,
                    title: "Profile edit",
                    subtitle: "Personal info, email, social",
                  ),
                ),
                SizedBox(height: 15.h),
                _buildSettingItem(
                  icon: Icons.lock_outline,
                  title: "Privacy",
                  subtitle: "Security, visibility, blocked users",
                ),
                SizedBox(height: 15.h),
                _buildSettingItem(
                  icon: Icons.help_outline,
                  title: "Help & Support",
                  subtitle: "FAQ, contact us, feedback",
                ),

                SizedBox(height: 60.h),

                // 4. Version Info
                Center(
                  child: Text(
                    "VERSION 1.0.0 (MONOLITH)",
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

  // Section Title Helper
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xFF4DB6AC),
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  // Setting Item Helper
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Container(
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
            child: Icon(icon, color: const Color(0xFFC3A0FF), size: 24.sp),
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
          Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16.sp),
        ],
      ),
    );
  }
}
