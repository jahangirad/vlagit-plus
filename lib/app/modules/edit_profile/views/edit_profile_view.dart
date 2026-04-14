import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../global_widgets/appbar_widget.dart';
import '../../../global_widgets/button_widget.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: "Profile Create",
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios,
                color: const Color(0xFFc799ff), size: 22.sp)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E0044), // Top purple glow
              Colors.black,
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Avatar Section
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: const Color(0xFF00E5FF).withOpacity(0.5),
                                  width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 60.r,
                              backgroundColor: const Color(0xFF1A1A1A),
                              // backgroundImage: AssetImage('assets/avatar.png'),
                            ),
                          ),
                          Positioned(
                            bottom: 5.r,
                            right: 5.r,
                            child: CircleAvatar(
                              radius: 18.r,
                              backgroundColor: const Color(0xFFc799ff),
                              child: Icon(Icons.add,
                                  color: Colors.black, size: 20.sp),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "CHANGE AVATAR",
                          style: TextStyle(
                            color: const Color(0xFF4DB6AC),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Form Fields
                _buildLabel("DISPLAY NAME"),
                _buildTextField("Elena Vance"),

                _buildLabel("TITLE / PROFESSION"),
                _buildTextField("e.g. Digital Architect"),

                _buildLabel("STATUS NOTE"),
                _buildTextField("Tell the world what you're up to...",
                    maxLines: 3),

                SizedBox(height: 25.h),
                Text(
                  "QR DATA",
                  style: TextStyle(
                    color: const Color(0xFFc799ff),
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 15.h),

                // Switch List Tiles
                _buildSwitchField("EMAIL ADDRESS", "elena.v@example.com", true),
                _buildSwitchField("WEBSITE URL", "www.elenavance.design", true),
                _buildSwitchField("PHONE NUMBER", "+1 (555) 000-0000", false),
                _buildSwitchField("SOCIAL MEDIA", "@elenavance_creative", true),

                // Location Visibility Card
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D0D0D).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: const Color(0xFF1A1A1A),
                        child: Icon(Icons.location_on,
                            color: const Color(0xFF4DB6AC), size: 20.sp),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Location Visibility",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp),
                            ),
                            Text(
                              "Allow others to see your city",
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 12.sp),
                            ),
                          ],
                        ),
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: true,
                          onChanged: (v) {},
                          activeColor: const Color(0xFF4DB6AC),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),

                // Bottom Save Button
                CustomButton(
                  text: "SAVE CHANGES",
                  onPressed: () {},
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widget for Labels
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 15.h),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF4DB6AC),
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  // Helper Widget for TextFields
  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white38, fontSize: 14.sp),
        filled: true,
        fillColor: const Color(0xFF0D0D0D).withOpacity(0.6),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Color(0xFFc799ff), width: 1),
        ),
      ),
    );
  }

  // Helper Widget for Switch Fields
  Widget _buildSwitchField(String label, String value, bool isSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Colors.white38,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h),
        Container(
          margin: EdgeInsets.only(bottom: 15.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0D).withOpacity(0.6),
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: isSelected,
                  onChanged: (v) {},
                  activeColor: const Color(0xFF4DB6AC),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}