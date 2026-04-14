import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/preview_controller.dart';

class PreviewView extends GetView<PreviewController> {
  const PreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // পুরো স্ক্রিনের ব্যাকগ্রাউন্ড গ্রেডিয়েন্ট
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E0044), // একদম উপরের বেগুনি ভাব
              Colors.black,
            ],
            stops: [0.0, 0.5],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 100.h), // অ্যাপবার বা ট্যাবের জন্য গ্যাপ

              Text(
                "DIGITAL PASS",
                style: TextStyle(
                  color: const Color(0xFF00E5FF), // ছবির মতো সায়ান কালার
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.5,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Your Identity",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),

              SizedBox(height: 40.h),

              // মূল আইডেন্টিটি কার্ড (ছবির মতো গ্রেডিয়েন্ট সহ)
              Container(
                width: 340.w,
                padding: EdgeInsets.symmetric(vertical: 45.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF150035), // কার্ডের উপরের ডার্ক পার্পল
                      const Color(0xFF050010), // কার্ডের নিচের ডার্ক ব্ল্যাক
                    ],
                  ),
                  borderRadius: BorderRadius.circular(55.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // প্রোফাইল ইমেজ (সায়ান গ্লোয়িং বর্ডার সহ)
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: EdgeInsets.all(3.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF00E5FF), // ছবির সেই সায়ান বর্ডার
                              width: 2.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00E5FF).withOpacity(0.4),
                                blurRadius: 15,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 65.r,
                            backgroundColor: Colors.grey[900],
                            // প্রোফাইল ছবি এখানে যুক্ত করবেন
                            backgroundImage: const NetworkImage(
                              'https://img.freepik.com/free-photo/lifestyle-beauty-fashion-people-concept-lovely-stylish-redhead-woman-wearing-black-dress_1258-150618.jpg',
                            ),
                          ),
                        ),
                        // ভেরিফাইড ব্যাজ
                        Positioned(
                          right: 8.w,
                          bottom: 5.h,
                          child: Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: const BoxDecoration(
                              color: Color(0xFF00E5FF),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.verified,
                              size: 18.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 25.h),

                    Text(
                      "Nora Smith",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Digital Creator",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // কিউআর কোড (ছবির মতো গোল কর্নার সহ)
                    Container(
                      width: 190.w,
                      height: 190.w,
                      padding: EdgeInsets.all(18.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                      child: Image.network(
                        'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=NoraSmith',
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: 30.h),

                    Text(
                      "ID: 8829-X01-PREVIEW",
                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 11.sp,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // নিচের বাটনগুলো
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildBottomButton(
                        icon: Icons.share_outlined,
                        label: "Share Profile",
                        color: const Color(0xFFC3A0FF), // ছবির সেই হালকা বেগুনি
                        textColor: Colors.black,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: _buildBottomButton(
                        icon: Icons.qr_code_scanner,
                        label: "Scan QR",
                        color: const Color(0xFF111111),
                        textColor: Colors.white,
                        hasBorder: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

  // বাটন তৈরির হেল্পার মেথড
  Widget _buildBottomButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
    bool hasBorder = false,
  }) {
    return Container(
      height: 65.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(35.r),
        border: hasBorder ? Border.all(color: Colors.white.withOpacity(0.1), width: 1.5) : null,
        boxShadow: !hasBorder
            ? [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: 22.sp),
          SizedBox(width: 10.w),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}