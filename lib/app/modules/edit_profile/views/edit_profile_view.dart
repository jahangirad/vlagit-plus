import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../global_widgets/button_widget.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
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
                            child: Obx(() => Container(
                                  width: 120.r,
                                  height: 120.r,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                  child: ClipOval(
                                    child: controller.imagePath.value.isNotEmpty && File(controller.imagePath.value).existsSync()
                                        ? Image.file(
                                            File(controller.imagePath.value),
                                            key: ValueKey(controller.imagePath.value),
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Icon(Icons.person, size: 60.sp, color: Colors.white24);
                                            },
                                          )
                                        : Icon(Icons.person, size: 60.sp, color: Colors.white24),
                                  ),
                                )),
                          ),
                          Positioned(
                            bottom: 5.r,
                            right: 5.r,
                            child: GestureDetector(
                              onTap: () => controller.pickImage(),
                              child: CircleAvatar(
                                radius: 18.r,
                                backgroundColor: const Color(0xFF00E5FF),
                                child: Icon(Icons.add,
                                    color: Colors.black, size: 20.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      TextButton(
                        onPressed: () => controller.pickImage(),
                        child: Text(
                          "CHANGE AVATAR",
                          style: TextStyle(
                            color: const Color(0xFF4DB6AC),
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                _buildLabel("Full Name"),
                _buildTextField("e.g. Elena Vance", controller.fullNameController, maxLength: 40),

                _buildLabel("Title"),
                _buildTextField("e.g. Digital Architect", controller.titleController, maxLength: 60),

                _buildLabel("Note"),
                _buildTextField("Tell the world what you're up to...",
                    controller.noteController,
                    maxLines: 3,
                    maxLength: 200),

                SizedBox(height: 15.h),

                Obx(() => Column(
                  children: [
                    _buildSwitchField("EMAIL ADDRESS", "e.g. elena.v@example.com", controller.emailController, controller.isEmailActive),
                    _buildSwitchField("WEBSITE URL", "e.g. www.elenavance.design", controller.websiteController, controller.isWebsiteActive),
                    _buildSwitchField("PHONE NUMBER", "e.g. +1 (555) 000-0000", controller.phoneController, controller.isPhoneActive),
                    _buildSwitchField("SOCIAL 1", "e.g. @username", controller.socialController, controller.isSocialActive),
                    _buildSwitchField("SOCIAL 2", "e.g. @username", controller.social2Controller, controller.isSocial2Active),
                  ],
                )),

                SizedBox(height: 40.h),

                CustomButton(
                  text: "SAVE CHANGES",
                  color: const Color(0xFF4DB6AC),
                  onPressed: () => controller.saveProfile(),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 15.h),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF4DB6AC),
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController textController, {int maxLines = 1, int? maxLength}) {
    return TextField(
      controller: textController,
      maxLines: maxLines,
      maxLength: maxLength,
      cursorColor: const Color(0xFF00E5FF), // Cursor Color added
      cursorWidth: 2.0,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        counterStyle: TextStyle(color: Colors.white24, fontSize: 10.sp),
        hintStyle: TextStyle(color: Colors.white24, fontSize: 13.sp),
        filled: true,
        fillColor: const Color(0xFF0D0D0D).withOpacity(0.6),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: Color(0xFF4DB6AC), width: 1),
        ),
      ),
    );
  }

  Widget _buildSwitchField(String label, String hint, TextEditingController textController, RxBool isActive) {
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
                child: TextField(
                  controller: textController,
                  cursorColor: const Color(0xFF00E5FF), // Cursor Color added
                  style: TextStyle(color: Colors.white70, fontSize: 13.sp),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.white24, fontSize: 12.sp),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: isActive.value,
                  onChanged: (v) => isActive.value = v,
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
