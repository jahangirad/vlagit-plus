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
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white70, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'FAQ',
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
        child: Obx(() => ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          itemCount: controller.faqs.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final faq = controller.faqs[index];
            return Container(
              margin: EdgeInsets.only(bottom: 15.h),
              decoration: BoxDecoration(
                color: const Color(0xFF0D0D0D).withOpacity(0.6),
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  iconColor: const Color(0xFF00E5FF),
                  collapsedIconColor: Colors.white24,
                  title: Text(
                    faq['question']!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceSerif4',
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
                      child: Text(
                        faq['answer']!,
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 14.sp,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )),
      ),
    );
  }
}
