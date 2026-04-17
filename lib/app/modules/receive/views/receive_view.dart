import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../global_widgets/bottom_sheet_widget.dart';
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
              "Anonymous Viewers",
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
                "Who's checking out your profile? Unlock to reveal all secret visitors.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: 5,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      CustomBottomSheet.showUnlockProfile();
                    },
                    child: _buildViewerCard(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewerCard(int index) {
    List<String> times = ["5M AGO", "12M AGO", "1H AGO", "3H AGO", "YESTERDAY"];
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
                  "New vlag!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Someone just viewed you",
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                times[index],
                style: TextStyle(
                  color: const Color(0xFF4DB6AC),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14.sp),
            ],
          ),
        ],
      ),
    );
  }
}
