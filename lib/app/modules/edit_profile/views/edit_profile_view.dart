import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121417),
      body: SafeArea(
        child: SingleChildScrollView(
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
                        CircleAvatar(
                          radius: 60.r, // Responsive radius
                          backgroundColor: const Color(0xFF1E2126),
                          // backgroundImage: AssetImage('assets/avatar.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: const Color(0xFFB388FF),
                            child: Icon(Icons.add, color: Colors.black, size: 20.sp),
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
              _buildTextField("Tell the world what you're up to...", maxLines: 3),

              SizedBox(height: 20.h),
              Text(
                "QR DATA",
                style: TextStyle(
                  color: const Color(0xFFB388FF),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
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
                  color: const Color(0xFF1E2126),
                  borderRadius: BorderRadius.circular(8.r), // Radius komano hoyeche
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: const Color(0xFF263238),
                      child: Icon(Icons.location_on, color: const Color(0xFF4DB6AC), size: 20.sp),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location Visibility",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.sp),
                          ),
                          Text(
                            "Allow others to see your city",
                            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
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
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB388FF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r), // Radius adjusted
                    ),
                  ),
                  child: Text(
                    "SAVE CHANGES",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Labels
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h, top: 12.h),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
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
        fillColor: const Color(0xFF1E2126),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
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
          style: TextStyle(color: Colors.grey, fontSize: 10.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5.h),
        Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2126),
            borderRadius: BorderRadius.circular(8.r), // Adjusted radius
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
                scale: 0.7, // Switch size control
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