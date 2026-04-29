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
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white70, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Contact Us',
          style: TextStyle(
            color: const Color(0xFF00E5FF),
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
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
              Color(0xFF0A0F1E),
              Color(0xFF000000),
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How can we help you?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceSerif4',
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "If you have any questions, feedback, or need technical support, feel free to reach out to us through any of the channels below.",
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14.sp,
                  height: 1.6,
                ),
              ),
              SizedBox(height: 40.h),
              _buildContactCard(
                icon: Icons.email_outlined,
                title: "Email Support",
                value: "support@vlagit.com",
                onTap: () => controller.launchEmail(),
              ),
              _buildContactCard(
                icon: Icons.language_outlined,
                title: "Official Website",
                value: "www.vlagit.com",
                onTap: () => controller.launchWebsite(),
              ),
              _buildContactCard(
                icon: Icons.telegram_outlined,
                title: "Telegram",
                value: "@vlagit_official",
                onTap: () => controller.launchTelegram(),
              ),
              SizedBox(height: 30.h),
              Center(
                child: Text(
                  "WE USUALLY RESPOND WITHIN 24 HOURS",
                  style: TextStyle(
                    color: const Color(0xFF4DB6AC),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
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
        margin: EdgeInsets.only(bottom: 18.h),
        padding: EdgeInsets.all(22.r),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D).withOpacity(0.6),
          borderRadius: BorderRadius.circular(25.r),
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
              child: Icon(icon, color: const Color(0xFF00E5FF), size: 22.sp),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white38, fontSize: 11.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    value,
                    style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: const Color(0xFF4DB6AC), size: 14.sp),
          ],
        ),
      ),
    );
  }
}
