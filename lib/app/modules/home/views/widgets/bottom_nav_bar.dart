import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../constant/app_images.dart';
import '../../controllers/home_controller.dart';

class HomeBottomBar extends GetView<HomeController>{
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16.w,
      right: 16.w,
      bottom: 12.h,
      child: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: controller.navItems.map((icon) => _navBarIcon(icon)).toList(),
          ),
        ),
      ),
    );
  }
}

Widget _navBarIcon(String icon) {
  return SizedBox(
    width: 32.w,
    height: 32.w,
    child: SvgPicture.asset(
    icon,
    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    ),
  );
}
