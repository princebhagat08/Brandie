import 'package:brandie/app/constant/app_colors.dart';
import 'package:brandie/app/constant/theme/theme_extension.dart';
import 'package:brandie/app/global_widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/smart_post_loading_controller.dart';

class SmartPostLoadingView extends GetView<SmartPostLoadingController> {
  const SmartPostLoadingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(height: 90.h,),
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(20.w, 45.h, 20.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity,height: 0.1.sh,),
            Text(
              "Building Personalized\nSmart Post for you!",
              textAlign: TextAlign.center,
              style: context.text.titleLarge?.copyWith(fontSize: 24.sp),
            ),

            SizedBox(height: 35.h),
            Expanded(
              child: ListView.separated(
                itemCount: controller.progressList.length + 1,
                separatorBuilder: (_, __) => SizedBox(height: 22.h),
                itemBuilder: (context, index) {
                  
                 
                    if (index == controller.progressList.length) {
                      return Obx(() {
                        final isAllCompleted = controller.progressList.every(
                          (item) => item.isCompleted.value,
                        );

                        if (!isAllCompleted) {
                          return const SizedBox.shrink();
                        }

                        return AnimatedOpacity(
                          opacity: isAllCompleted ? 1 : 0,
                          duration: const Duration(milliseconds: 400),
                          child: Padding(
                            padding: EdgeInsets.only(top: 12.h),
                            child: Text(
                              "All set! Get ready to share...",
                              textAlign: TextAlign.center,
                              style: context.text.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      });
                    }
                    final item = controller.progressList[index];
                    return Obx(
                      ()=> _rowItem(
                        context,
                        title: item.title,
                        isLoading: item.isLoading.value,
                        isCompleted: item.isCompleted.value,
                      ),
                    );
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _rowItem(
  BuildContext context, {
  required String title,
  required bool isLoading,
  required bool isCompleted,
}) {
  Widget leading;

  if (isCompleted) {
    leading = Icon(
      Icons.check_circle,
      color: AppColor.primaryColor,
      size: 26.h,
    );
  } else if (isLoading) {
    leading = SizedBox(
      height: 21.h,
      width: 21.h,
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        color: AppColor.primaryColor,
      ),
    );
  } else {
    leading = Icon(
      Icons.radio_button_unchecked,
      color: Colors.grey,
      size: 26.h,
    );
  }

  return Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 230.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leading,
          SizedBox(width: 15.w),

          Expanded(
            child: Text(
              title,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: context.text.bodyLarge?.copyWith(
                fontWeight: isCompleted || isLoading ? FontWeight.bold : null,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
