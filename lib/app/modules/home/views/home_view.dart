import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../edit_profile/views/edit_profile_view.dart';
import '../../preview/views/preview_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        // অ্যাপবার আপনার চাহিদা মতো উপরেই থাকছে
        appBar: AppBar(
          backgroundColor: Color(0xFF130c1a),
          elevation: 0,
          leading: Icon(Icons.visibility_outlined, color: Color(0xFFc799ff), size: 22.sp),
          title: Text(
            'Vlagit Plus',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings_outlined, color: Color(0xFFb9b6bb), size: 22.sp),
            ),
          ],
        ),
        body: Stack(
          children: [
            // ১. স্ক্রিন কন্টেন্ট (যা অ্যাপবারের নিচ থেকে শুরু হবে)
            const TabBarView(
              children: [
                EditProfileView(),
                PreviewView(),
              ],
            ),

            // ২. এডিট ও প্রিভিউ বাটন (যা স্ক্রিনের ওপর ভাসমান থাকবে)
            Positioned(
              top: 15.h, // অ্যাপবার থেকে সামান্য নিচে
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 45.h,
                  width: 210.w,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A).withOpacity(0.9), // হালকা স্বচ্ছ
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: const Color(0xFF333333),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white38,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                    tabs: const [
                      Tab(text: 'EDIT'),
                      Tab(text: 'PREVIEW'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}