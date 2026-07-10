import 'dart:async';

import 'package:brandie/app/constant/app_images.dart';
import 'package:brandie/app/constant/theme/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/app_colors.dart';

class QuickShareLoaderDialog extends StatefulWidget {
  const QuickShareLoaderDialog();

  @override
  State<QuickShareLoaderDialog> createState() => _QuickShareLoaderDialogState();
}

class _QuickShareLoaderDialogState extends State<QuickShareLoaderDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Timer _messageTimer;
  int _messageIndex = 0;

  final List<String> _messages = const [
    'Generating link',
    'Copying caption',
    'Saving content',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _messageTimer = Timer.periodic(const Duration(milliseconds: 850), (_) {
      if (!mounted) return;
      setState(() {
        _messageIndex = (_messageIndex + 1) % _messages.length;
      });
    });
  }

  @override
  void dispose() {
    _messageTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              width: 66.w,
              height: 66.w,
              child:CircleAvatar(
                radius: 22.r,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(AppImages.O),
                ),
              ),
              
            ),
            SizedBox(height: 8.h),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              child: Text(
                _messages[_messageIndex],
                key: ValueKey(_messageIndex),
                textAlign: TextAlign.center,
                style: context.text.titleMedium?.copyWith(color: AppColor.grey)
              ),
            ),
            SizedBox(height: 18.h),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(999.r),
                  child: Container(
                    height: 14.h,
                    width: double.infinity,
                    color: AppColor.grey,
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(999.r),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
