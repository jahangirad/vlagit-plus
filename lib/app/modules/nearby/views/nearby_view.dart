import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:vlagit_plus/app/global_widgets/appbar_widget.dart';
import '../../../global_widgets/bottom_sheet_widget.dart';
import '../../../global_widgets/button_widget.dart';
import '../controllers/nearby_controller.dart';

class NearbyView extends GetView<NearbyController> {
  const NearbyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A0033),
              Colors.black,
            ],
            stops: [0.0, 0.4],
          ),
        ),
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
                            "Your device \"Orion-Pro\" is visible to everyone nearby",
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

              // Responsive Grid using responsive_grid package
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: ResponsiveGridRow(
                      children: [
                        _buildResponsiveCard("Arjun", "https://img.freepik.com/free-photo/view-3d-man-holding-hands-pockets_23-2150709923.jpg"),
                        _buildResponsiveCard("Sarah", "https://img.freepik.com/free-photo/view-3d-woman-holding-hands-pockets_23-2150709925.jpg"),
                        _buildResponsiveCard("Alex", "https://img.freepik.com/free-photo/view-3d-man-holding-hands-pockets_23-2150709923.jpg"),
                        _buildResponsiveCard("Jordan", "https://img.freepik.com/free-photo/view-3d-woman-holding-hands-pockets_23-2150709925.jpg"),
                      ],
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

  ResponsiveGridCol _buildResponsiveCard(String name, String imageUrl) {
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
                backgroundColor: Colors.grey[900],
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.h),
            CustomButton(
              text: "SEND",
              icon: Icons.play_arrow,
              height: 42.h,
              width: 120.w,
              color: const Color(0xFFC3A0FF),
              onPressed: () {
                CustomBottomSheet.showUnlockProfile();
              },
            ),
          ],
        ),
      ),
    );
  }
}
