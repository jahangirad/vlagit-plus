import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/receive_controller.dart';

class ReceiveView extends GetView<ReceiveController> {
  const ReceiveView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 70.h),
            Text(
              "Received Profiles",
              style: TextStyle(
                color: const Color(0xFFC3A0FF),
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                "People who shared their profile with you on this network.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Expanded(
              child: Obx(() => ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: controller.receivedList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final profile = controller.receivedList[index];
                  return GestureDetector(
                    onTap: () {
                      _showProfileDetails(profile);
                    },
                    child: _buildViewerCard(profile),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileDetails(Map<String, dynamic> profile) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 50.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                profile['fullName'] ?? "No Name",
                style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                profile['title'] ?? "",
                style: TextStyle(color: const Color(0xFFC3A0FF), fontSize: 16.sp),
              ),
              SizedBox(height: 20.h),
              if (profile['note']?.isNotEmpty == true) ...[
                Text("Note", style: TextStyle(color: Colors.white60, fontSize: 12.sp)),
                Text(profile['note'], style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                SizedBox(height: 15.h),
              ],
              _buildDetailItem(Icons.email, "Email", profile['email'], profile['isEmailActive']),
              _buildDetailItem(Icons.language, "Website", profile['website'], profile['isWebsiteActive']),
              _buildDetailItem(Icons.phone, "Phone", profile['phone'], profile['isPhoneActive']),
              _buildDetailItem(Icons.link, "Social 1", profile['social'], profile['isSocialActive']),
              _buildDetailItem(Icons.link, "Social 2", profile['social2'], profile['isSocial2Active']),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String? value, dynamic isActive) {
    if (value == null || value.isEmpty || isActive == false) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.white38, size: 20.sp),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: Colors.white38, fontSize: 10.sp)),
              Text(value, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildViewerCard(Map<String, dynamic> profile) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D).withOpacity(0.6),
        borderRadius: BorderRadius.circular(35.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A1A),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: Colors.white, size: 30.sp),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile['fullName'] ?? "New User",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profile['title'] ?? "Shared their profile",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14.sp),
        ],
      ),
    );
  }
}
