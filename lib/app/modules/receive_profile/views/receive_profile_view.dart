import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/receive_profile_controller.dart';

class ReceiveProfileView extends GetView<ReceiveProfileController> {
  const ReceiveProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = controller.profile;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Profile Preview',
          style: TextStyle(
            color: const Color(0xFFC3A0FF),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            radius: 1.5,
            colors: [
              Color(0xFF1E0B36), // Deep Purple glow
              Color(0xFF000000), // Solid Black
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 110.h),
              
              // Profile Image with Glow and Verified Badge
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: EdgeInsets.all(3.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF7B61FF).withOpacity(0.3),
                          blurRadius: 30,
                          spreadRadius: 5,
                        )
                      ],
                      border: Border.all(color: Colors.white24, width: 1),
                    ),
                    child: CircleAvatar(
                      radius: 75.r,
                      backgroundColor: Colors.grey[900],
                      backgroundImage: profile['profileImage'] != null 
                          ? MemoryImage(base64Decode(profile['profileImage']))
                          : null,
                      child: profile['profileImage'] == null 
                          ? Icon(Icons.person, size: 70.sp, color: Colors.white24)
                          : null,
                    ),
                  ),
                  Positioned(
                    right: 8.w,
                    bottom: 8.h,
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00F5FF), // Cyan Verified
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
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
              
              // Name
              Text(
                profile['fullName'] ?? "Elena Vance",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              
              // Title
              Text(
                (profile['title'] ?? "Creative Director & Designer").toUpperCase(),
                style: TextStyle(
                  color: const Color(0xFF00F5FF), // Cyan
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
              
              SizedBox(height: 25.h),
              
              // Bio/Note Card
              if (profile['note'] != null && profile['note'].toString().isNotEmpty)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.w),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Text(
                    "\"${profile['note']}\"",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              
              SizedBox(height: 40.h),
              
              // Contact Section Label
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CONTACT INFORMATION",
                      style: TextStyle(
                        color: const Color(0xFF00F5FF),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Generated via secure encrypted profile sharing protocols.",
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 12.sp,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 25.h),

              // Info Cards (Obsidian Style)
              _buildObsidianCard(
                icon: Icons.email_rounded,
                label: "EMAIL ADDRESS",
                value: profile['email'],
                isActive: profile['isEmailActive'],
                accentColor: const Color(0xFFC3A0FF),
              ),
              _buildObsidianCard(
                icon: Icons.language_rounded,
                label: "WEBSITE",
                value: profile['website'],
                isActive: profile['isWebsiteActive'],
                accentColor: const Color(0xFF00F5FF),
              ),
              _buildObsidianCard(
                icon: Icons.phone_rounded,
                label: "PHONE NUMBER",
                value: profile['phone'],
                isActive: profile['isPhoneActive'],
                accentColor: const Color(0xFFFF7B7B),
              ),
              // Updated Social 1 as Facebook
              _buildObsidianCard(
                icon: Icons.facebook_rounded,
                label: "FACEBOOK",
                value: profile['social'],
                isActive: profile['isSocialActive'],
                accentColor: const Color(0xFF1877F2), // FB Blue
              ),
              // Updated Social 2 as Instagram
              _buildObsidianCard(
                icon: Icons.camera_alt_rounded, // Better Instagram icon representation
                label: "INSTAGRAM",
                value: profile['social2'],
                isActive: profile['isSocial2Active'],
                accentColor: const Color(0xFFE4405F), // IG Pink/Red
              ),

              SizedBox(height: 50.h),
              
              // Footer
              Text(
                "IDENTITY VERIFIED • ETHEREAL OBSIDIAN",
                style: TextStyle(
                  color: Colors.white10,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildObsidianCard({
    required IconData icon,
    required String label,
    required String? value,
    required dynamic isActive,
    required Color accentColor,
  }) {
    if (value == null || value.isEmpty || isActive == false) return const SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accentColor, size: 22.sp),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
