import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';
import '../modules/preview/controllers/preview_controller.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
      margin: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D).withOpacity(0.8),
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFooterItem(Icons.share_outlined, "Share", () {
            // Find PreviewController and trigger share
            if (Get.isRegistered<PreviewController>()) {
              Get.find<PreviewController>().captureAndShare();
            } else {
              Get.snackbar("Notice", "Go to Preview to share your card.", 
                backgroundColor: Colors.orange.withOpacity(0.7), colorText: Colors.white);
            }
          }),
          _buildFooterItem(Icons.qr_code_scanner, "Scan", () {
            Get.toNamed(Routes.QR_CODE);
          }),
          _buildFooterItem(Icons.near_me_outlined, "Nearby", () {
            Get.toNamed(Routes.NEARBY);
          }),
        ],
      ),
    );
  }

  Widget _buildFooterItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF00E5FF), size: 26.sp),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}
