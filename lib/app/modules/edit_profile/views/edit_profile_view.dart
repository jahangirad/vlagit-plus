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
                SizedBox(height: 70.h),
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
                _buildLabel("Full Name"),
                _buildTextField("Elena Vance"),

                _buildLabel("Tittle"),
                _buildTextField("e.g. Digital Architect"),

                _buildLabel("Note"),
                _buildTextField("Tell the world what you're up to...",
                    maxLines: 3),

                SizedBox(height: 15.h),

                // Switch List Tiles
                _buildSwitchField("EMAIL ADDRESS", "elena.v@example.com", true),
                _buildSwitchField("WEBSITE URL", "www.elenavance.design", true),
                _buildSwitchField("PHONE NUMBER", "+1 (555) 000-0000", false),
                _buildSwitchField("SOCIAL MEDIA", "@elenavance_creative", true),
                _buildSwitchField("SOCIAL MEDIA", "@elenavance_creative", true),


                SizedBox(height: 40.h),

                // Bottom Save Button
                CustomButton(
                  text: "SAVE CHANGES",
                  onPressed: () {},
                ),
                SizedBox(height: 50.h),
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