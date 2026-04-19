import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});
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
          'FAQ',
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
        child: Obx(() => ListView.builder(
          padding: EdgeInsets.all(20.r),
          itemCount: controller.faqs.length,
          itemBuilder: (context, index) {
            final faq = controller.faqs[index];
            return Container(
              margin: EdgeInsets.only(bottom: 15.h),
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: ExpansionTile(
                iconColor: const Color(0xFF00F5FF),
                collapsedIconColor: Colors.white38,
                title: Text(
                  faq['question']!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 20.h),
                    child: Text(
                      faq['answer']!,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )),
      ),
    );
  }
}
