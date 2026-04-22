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
            SizedBox(height: 80.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                "List of people who shared their profile with you locally on Vlagit",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF00E5FF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            SizedBox(height: 30.h),
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
                        color: Colors.redAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Icon(Icons.delete_sweep_rounded, color: Colors.redAccent, size: 28.sp),
                    ),
                    onDismissed: (direction) {
                      controller.deleteProfile(index);
                    },
                    child: GestureDetector(
                      onTap: () {
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

  Widget _buildViewerCard(Map<String, dynamic> profile) {
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
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFF00E5FF).withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.visibility_outlined, color: const Color(0xFF00E5FF), size: 24.sp),
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
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  profile['title'] ?? "Shared their profile",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: const Color(0xFF4DB6AC), size: 14.sp),
        ],
      ),
    );
  }
}
