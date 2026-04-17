import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  
  // 0: Receive, 1: Edit, 2: Preview, 3: Profile, 4: QR_Scan, 5: Nearby
  // অ্যাপ ওপেন হলে Edit (1) ভিউ দেখাবে
  final RxInt currentIndex = 1.obs; 

  @override
  void onInit() {
    super.onInit();
    // initialIndex: 0 মানে 'Edit' ট্যাবটি ডিফল্ট সিলেক্ট থাকবে
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        // ট্যাব পরিবর্তন হলে বডির ইনডেক্স আপডেট হবে (Edit=0, Preview=1 পজিশন)
        if (tabController.index == 0) currentIndex.value = 1;
        if (tabController.index == 1) currentIndex.value = 2;
      }
    });
  }

  void changePage(int index) {
    currentIndex.value = index;
    // যদি কোড থেকে Edit বা Preview তে যাওয়া হয়, তবে Tab ইন্ডিকেটরও মুভ করবে
    if (index == 1) {
      tabController.animateTo(0);
    } else if (index == 2) {
      tabController.animateTo(1);
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
