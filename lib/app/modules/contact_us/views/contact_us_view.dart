import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white70),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Contact Us',
          style: TextStyle(
            color: const Color(0xFFC3A0FF),
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            radius: 1.5,
            colors: [
              Color(0xFF1E0B36),
              Color(0xFF000000),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(25.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How can we help you?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "If you have any questions, feedback, or need technical support, feel free to reach out to us through any of the channels below.",
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 40.h),
              _buildContactCard(
                icon: Icons.email_outlined,
                title: "Email Support",
                value: "support@vlagit.com",
                onTap: () {},
              ),
              _buildContactCard(
                icon: Icons.language_outlined,
                title: "Official Website",
                value: "www.vlagit.com",
                onTap: () {},
              ),
              _buildContactCard(
                icon: Icons.telegram_outlined,
                title: "Telegram",
                value: "@vlagit_official",
                onTap: () {},
              ),
              SizedBox(height: 40.h),
              // Container(
              //   padding: EdgeInsets.all(20.r),
              //   decoration: BoxDecoration(
              //     color: Colors.white.withOpacity(0.03),
              //     borderRadius: BorderRadius.circular(20.r),
              //     border: Border.all(color: Colors.white10),
              //   ),
              //   child: Column(
              //     children: [
              //       Text(
              //         "Business Inquiries",
              //         style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(height: 8.h),
              //       Text(
              //         "For partnership or business related queries, please contact our business team.",
              //         textAlign: TextAlign.center,
              //         style: TextStyle(color: Colors.white38, fontSize: 12.sp),
              //       ),
              //       SizedBox(height: 15.h),
              //       Text(
              //         "biz@vlagit.com",
              //         style: TextStyle(color: const Color(0xFF00F5FF), fontSize: 14.sp, fontWeight: FontWeight.bold),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({required IconData icon, required String title, required String value, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFFC3A0FF), size: 22.sp),
            ),
            SizedBox(width: 20.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white38, fontSize: 11.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  value,
                  style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
