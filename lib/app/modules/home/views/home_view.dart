import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../global_widgets/appbar_widget.dart';
import '../../../global_widgets/bottom_nav_widget.dart';
import '../../edit_profile/views/edit_profile_view.dart';
import '../../preview/views/preview_view.dart';
import '../../profile/views/profile_view.dart';
import '../../receive/views/receive_view.dart';
import '../../qr_code/views/qr_code_view.dart';
import '../../nearby/views/nearby_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1E0044),
            Colors.black,
          ],
          stops: [0.0, 0.5],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: Stack(
          children: [
            Obx(() {
              return IndexedStack(
                index: controller.currentIndex.value,
                children: const [
                  ReceiveView(),      // 0
                  EditProfileView(),  // 1
                  PreviewView(),      // 2
                  ProfileView(),      // 3
                  QrCodeView(),       // 4
                  NearbyView(),       // 5
                ],
              );
            }),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomAppBar(
                tabController: controller.tabController,
                onEyePressed: () => controller.changePage(0),
                onSettingsPressed: () => controller.changePage(3),
                onTabChanged: (index) => controller.changePage(index + 1),
              ),
            ),
            Obx(() {
              // Show bottom nav only on Preview tab
              if (controller.currentIndex.value == 2) {
                return const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomBottomNav(),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
