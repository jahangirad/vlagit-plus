import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onSettingsPressed;
  final Widget? leading;
  final Widget? actionIcon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onSettingsPressed,
    this.leading,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF130c1a),
      elevation: 0,
      leading: leading, // এখানে null পাঠালে ডিফল্ট ব্যাক বাটন আসবে (যদি থাকে)
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
      centerTitle: true,
      actions: [
        // actionIcon যদি null না হয় তবেই এটি লিস্টে যোগ হবে
        if (actionIcon != null) actionIcon!,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}