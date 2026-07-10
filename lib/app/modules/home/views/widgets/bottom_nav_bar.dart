import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_images.dart';
import '../../controllers/home_controller.dart';

class HomeBottomBar extends GetView<HomeController> {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Positioned(
        left: 16.w,
        right: 16.w,
        bottom: 12.h,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(controller.navItems.length, (index) {
                final isSelected = controller.selectedBottomNav.value == index;
                return _NavBarIcon(
                  icon: controller.navItems[index],
                  isSelected: isSelected,
                  onTap: () => controller.onBottomNavChanged(index),
                );
              }),
            ),
          ),
        ),
      );
    });
  }
}

class _NavBarIcon extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarIcon({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 36.w,
        height: 36.w,
        child: Center(
          child: SvgPicture.asset(
            icon,
            width: 28.w,
            height: 28.w,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColor.primaryColor : Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
