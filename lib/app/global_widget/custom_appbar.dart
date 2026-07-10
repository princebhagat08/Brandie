import 'package:brandie/app/constant/app_colors.dart';
import 'package:brandie/app/constant/theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/app_images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  const CustomAppBar({super.key, this.bottom});

  @override
  Size get preferredSize => Size.fromHeight(135.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 1,
      toolbarHeight: 82.h,

      title: Row(
        children: [
          /// Assistant
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundColor: context.appColors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(AppImages.O, scale: 5),
                      ),
                    ),

                    Positioned(
                      right: -8,
                      top: -3,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(5.r)
                        ),
                        child: Text("AI",style: TextStyle(fontSize: 14.sp,color: AppColor.whiteColor),),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Your Assistant",
                style: context.text.bodySmall?.copyWith(fontSize: 12.sp),
              ),
            ],
          ),

          const Spacer(),

          /// Logo
          Image.asset(AppImages.appTitleImg, height: 75.h),

          const Spacer(),

          /// Camera
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 25.r,
                  backgroundColor: context.appColors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.camera_alt),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "Camera",
                style: context.text.bodySmall?.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),

      bottom: bottom,
    );
  }
}
