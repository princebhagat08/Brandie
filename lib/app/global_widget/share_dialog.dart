import 'package:brandie/app/constant/app_colors.dart';
import 'package:brandie/app/constant/app_images.dart';
import 'package:brandie/app/constant/theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../modules/home/controllers/share_dialog_controller.dart';


class ShareDialog extends StatelessWidget {
  final String tag;

  const ShareDialog({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShareDialogController>(tag: tag);

    return Obx(() {
      return AlertDialog(
        backgroundColor: context.appColors.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        content: SizedBox(
          width: 350.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 65.w,
                height: 65.w,
                child: CircleAvatar(
                  radius: 15.r,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(AppImages.O),
                  ),
                ),),
              SizedBox(height: 12.h),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                child: Text(
                  controller.currentMessage.value,
                  key: ValueKey(controller.currentMessage.value),
                  textAlign: TextAlign.center,
                  style: context.text.titleSmall?.copyWith(
                    color: AppColor.grey,
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(999.r),
                child: Container(
                  height: 14.h,
                  width: double.infinity,
                  color: AppColor.grey.withValues(alpha: 0.28),
                  alignment: Alignment.centerLeft,
                  child: AnimatedFractionallySizedBox(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                    widthFactor: controller.progress.value <= 0
                        ? 0.18
                        : controller.progress.value.clamp(0.18, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

