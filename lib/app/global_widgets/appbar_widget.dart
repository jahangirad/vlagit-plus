import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../modules/home/controllers/home_controller.dart';

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
    final HomeController homeController = Get.find<HomeController>();

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D).withOpacity(0.7),
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Obx(() {
          int currentIndex = homeController.currentIndex.value;

          return Row(
            children: [
              // Eye Icon (Receive/View)
              IconButton(
                icon: Icon(
                  Icons.visibility_outlined,
                  color: currentIndex == 0 ? const Color(0xFF00E5FF) : Colors.white24,
                  size: 24.sp,
                ),
                onPressed: onEyePressed ?? () {},
              ),
              
              // Tabs (Edit & Preview)
              Expanded(
                child: TabBar(
                  onTap: onTabChanged,
                  controller: tabController,
                  indicator: const BoxDecoration(), // Fully removes the indicator box
                  indicatorColor: Colors.transparent, 
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white24,
                  labelPadding: EdgeInsets.zero,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16.sp,
                    letterSpacing: 1.2,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.sp,
                  ),
                  tabs: const [
                    Tab(text: 'EDIT'),
                    Tab(text: 'PREVIEW'),
                  ],
                ),
              ),

              // Settings Icon
              IconButton(
                onPressed: onSettingsPressed ?? () {},
                icon: Icon(
                  Icons.settings_outlined,
                  color: currentIndex == 3 ? const Color(0xFFC3A0FF) : Colors.white24,
                  size: 24.sp,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
