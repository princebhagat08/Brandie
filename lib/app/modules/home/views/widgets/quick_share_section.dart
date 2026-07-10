import 'dart:async';

import 'package:brandie/app/constant/app_colors.dart';
import 'package:brandie/app/constant/app_images.dart';
import 'package:brandie/app/constant/theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/model/media_model.dart';
import '../../../../data/model/quick_share_model.dart';
import '../../controllers/home_controller.dart';

class QuickShareSection extends GetView<HomeController> {
  const QuickShareSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16.w,
      right: 16.w,
      bottom: 75.h,
      child: SizedBox(
        height: 50.h,
        child: Row(
          children: [
            Text(
              "Quick share to:",
              style: context.text.bodyMedium?.copyWith(
                color: AppColor.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.quickShareItems.length,
                separatorBuilder: (_, __) => SizedBox(width: 3.w),
                itemBuilder: (context, index) {
                  final item = controller.quickShareItems[index];
                  return _socialButton(
                    icon: item.icon,
                    onTap: () async{await controller.handleQuickShare(context, item);},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }}



  
 Widget _socialButton({
    required String icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 32.r,
        backgroundColor: Colors.grey.withAlpha(200),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(icon),
        ),
      ),
    );
  }

  