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
              // Header with Refresh Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "DISCOVERY ACTIVE",
                          style: TextStyle(
                            color: const Color(0xFF00E5FF),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => controller.refreshDiscovery(),
                          icon: Icon(Icons.refresh_rounded, color: const Color(0xFF00E5FF), size: 24.sp),
                          tooltip: "Refresh List",
                        ),
                      ],
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
                        _buildAnimatedPulse(),
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
                child: Obx(() => controller.devices.isEmpty 
                  ? _buildEmptyState()
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: ResponsiveGridRow(
                          children: controller.devices.map((device) {
                            return _buildResponsiveCard(device);
                          }).toList(),
                        ),
                      ),
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedPulse() {
    return Container(
      width: 8.w,
      height: 8.w,
      decoration: const BoxDecoration(
        color: Color(0xFF00E5FF),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00E5FF),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_find_rounded, size: 80.sp, color: Colors.white10),
          SizedBox(height: 20.h),
          Text(
            "No devices found yet",
            style: TextStyle(color: Colors.white38, fontSize: 16.sp),
          ),
          SizedBox(height: 10.h),
          Text(
            "Ensure others are on the same Wi-Fi",
            style: TextStyle(color: Colors.white10, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  ResponsiveGridCol _buildResponsiveCard(NearbyDevice device) {
    return ResponsiveGridCol(
      xs: 6,
      child: Container(
        margin: EdgeInsets.all(8.r),
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
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
                    color: const Color(0xFF00E5FF).withOpacity(0.1),
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
                    color: const Color(0xFF00E5FF),
                    fontWeight: FontWeight.w600, // SemiBold for our font
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              device.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
              color: const Color(0xFF4DB6AC),
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
