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
                  return Dismissible(
                    key: Key(profile['fullName'] + index.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 30.w),
                      margin: EdgeInsets.only(bottom: 15.h),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(35.r),
                      ),
                      child: Icon(Icons.delete_sweep, color: Colors.redAccent, size: 28.sp),
                    ),
                    onDismissed: (direction) {
                      controller.deleteProfile(index);
                    },
                    child: GestureDetector(
                      onTap: () {
                        // Check if profile is already "unlocked" or just show ad
                        controller.showAdAndOpenProfile(profile);
                      },
                      child: _buildViewerCard(profile),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  // Removed old _showViewAdBottomSheet and _showProfileDetails methods as they are now handled in ReceiveController
  // and ReceiveProfileView for a cleaner flow.

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
            child: Icon(Icons.visibility, color: Colors.white, size: 30.sp),
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
