import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import '../../../global_widgets/button_widget.dart';
import '../controllers/nearby_controller.dart';

class NearbyView extends GetView<NearbyController> {
  const NearbyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // texts
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "DISCOVERY ACTIVE",
                      style: TextStyle(
                        color: const Color(0xFF00E5FF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Searching for devices...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF00E5FF),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            "Visible to everyone on the same network",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Responsive Grid showing dynamic devices
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Obx(() => ResponsiveGridRow(
                      children: controller.devices.map((device) {
                        return _buildResponsiveCard(device);
                      }).toList(),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ResponsiveGridCol _buildResponsiveCard(NearbyDevice device) {
    return ResponsiveGridCol(
      xs: 6,
      child: Container(
        margin: EdgeInsets.all(8.r),
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          borderRadius: BorderRadius.circular(35.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(3.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: CircleAvatar(
                radius: 40.r,
                backgroundColor: const Color(0xFF1A1A1A),
                child: Text(
                  device.name.isNotEmpty ? device.name[0].toUpperCase() : "?",
                  style: TextStyle(
                    fontSize: 32.sp, 
                    color: const Color(0xFFC3A0FF),
                    fontWeight: FontWeight.w600, // SemiBold for our font
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              device.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            CustomButton(
              text: "SEND",
              icon: Icons.send,
              height: 42.h,
              width: 120.w,
              color: const Color(0xFFC3A0FF),
              onPressed: () {
                controller.sendDataToDevice(device);
              },
            ),
          ],
        ),
      ),
    );
  }
}
