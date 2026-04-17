import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController? tabController;
  final VoidCallback? onSettingsPressed;
  final VoidCallback? onEyePressed;
  final Function(int)? onTabChanged;

  const CustomAppBar({
    super.key,
    this.tabController,
    this.onSettingsPressed,
    this.onEyePressed,
    this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D).withOpacity(0.7),
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.visibility_outlined,
                  color: const Color(0xFFc799ff), size: 24.sp),
              onPressed: onEyePressed ?? () {},
            ),
            Expanded(
              child: TabBar(
                onTap: onTabChanged,
                controller: tabController,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white38,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
                tabs: const [
                  Tab(text: 'Edit'),
                  Tab(text: 'Preview'),
                ],
              ),
            ),
            IconButton(
              onPressed: onSettingsPressed ?? () {},
              icon: Icon(Icons.settings_outlined,
                  color: Colors.white70, size: 24.sp),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
