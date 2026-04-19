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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Profile Preview',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8E7AB5), // Lighter purple top
              Color(0xFFF4F1F8), // Light grayish/white bottom
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 100.h),
              // Profile Image with Verified Badge
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: CircleAvatar(
                      radius: 70.r,
                      backgroundColor: Colors.grey[300],
                      // Note: Remote profile might not have a local file path for image
                      // For now, using a placeholder icon. 
                      // If you send image bytes, you'd handle it differently.
                      child: Icon(Icons.person, size: 70.sp, color: Colors.grey),
                    ),
                  ),
                  Positioned(
                    right: 10.w,
                    bottom: 5.h,
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1DB954), // Verified green
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.verified,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              // Name
              Text(
                profile['fullName'] ?? "No Name",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              // Title
              Text(
                (profile['title'] ?? "DESIGNER").toUpperCase(),
                style: TextStyle(
                  color: const Color(0xFF4A908A),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 15.h),
              // Note Card
              if (profile['note'] != null && profile['note'].toString().isNotEmpty)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.w),
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "\"${profile['note']}\"",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13.sp,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              
              SizedBox(height: 30.h),
              
              // Contact Info Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CONTACT INFORMATION",
                      style: TextStyle(
                        color: const Color(0xFF4A908A),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Generated via secure encrypted profile sharing protocols.",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20.h),

              // Info Cards
              _buildInfoCard(
                icon: Icons.email,
                label: "EMAIL ADDRESS",
                value: profile['email'],
                isActive: profile['isEmailActive'],
                iconColor: const Color(0xFF7B61FF),
                iconBg: const Color(0xFFEBE7FF),
              ),
              _buildInfoCard(
                icon: Icons.language,
                label: "WEBSITE",
                value: profile['website'],
                isActive: profile['isWebsiteActive'],
                iconColor: const Color(0xFF4A908A),
                iconBg: const Color(0xFFE8F4F3),
              ),
              _buildInfoCard(
                icon: Icons.phone,
                label: "PHONE NUMBER",
                value: profile['phone'],
                isActive: profile['isPhoneActive'],
                iconColor: const Color(0xFFFF6161),
                iconBg: const Color(0xFFFFEAEA),
              ),
              _buildInfoCard(
                icon: Icons.alternate_email,
                label: "INSTAGRAM",
                value: profile['social'],
                isActive: profile['isSocialActive'],
                iconColor: const Color(0xFFA161FF),
                iconBg: const Color(0xFFF2EAFF),
              ),

              SizedBox(height: 40.h),
              Text(
                "IDENTITY VERIFIED • ETHEREAL OBSIDIAN",
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String? value,
    required dynamic isActive,
    required Color iconColor,
    required Color iconBg,
  }) {
    if (value == null || value.isEmpty || isActive == false) return const SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
