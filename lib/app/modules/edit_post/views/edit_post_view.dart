import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../constant/app_colors.dart';
import '../controllers/edit_post_controller.dart';

class EditPostView extends GetView<EditPostController> {
  const EditPostView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Post"),
        leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.close,size: 35.sp,),),
        actions: [
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
            () => GestureDetector(
              onTap: controller.isChanged.value
                  ? controller.save
                  : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 6.h),
                decoration: BoxDecoration(
                  color: controller.isChanged.value? AppColor.primaryColor:AppColor.primaryColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(18.r)
                ),
                child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.bold),),
              ),
            )
          ),
          )
        ],
      ),
    
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [

            TextField(
              controller: controller.captionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Caption",
              ),
            ),

            SizedBox(height: 20.h),

            TextField(
              controller: controller.hashtagController,
              decoration: const InputDecoration(
                labelText: "Hashtags",
              ),
            ),

            SizedBox(height: 20.h),

            TextField(
              controller: controller.codeController,
              decoration: const InputDecoration(
                labelText: "Referral Code",
              ),
            ),

            SizedBox(height: 20.h),

            TextField(
              controller: controller.linkController,
              decoration: const InputDecoration(
                labelText: "Product Link",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
