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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white70, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "NEARBY DISCOVERY",
          style: TextStyle(
            color: const Color(0xFF00E5FF),
            fontSize: 16.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => controller.refreshDiscovery(),
            icon: Icon(Icons.refresh_rounded, color: const Color(0xFF00E5FF), size: 24.sp),
            tooltip: "Refresh List",
          ),
          SizedBox(width: 10.w),
        ],
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            radius: 1.5,
            colors: [
              Color(0xFF0A0F1E),
              Color(0xFF000000),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              // Simplified UI - Only Grid
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_find_rounded, size: 80.sp, color: Colors.white10),
          SizedBox(height: 20.h),
          Text(
            "Searching for nearby users...",
            style: TextStyle(color: Colors.white38, fontSize: 16.sp),
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
                    fontWeight: FontWeight.w600,
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
