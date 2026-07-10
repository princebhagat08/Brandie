import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class AppTextTheme {
  AppTextTheme._();

  static String fontFamily = 'Poppins';

  static TextTheme lightTextTheme = TextTheme(
    
    displayLarge: TextStyle(
      fontSize: 50.sp,
      fontWeight: FontWeight.w900,
      color: Colors.black,
      fontFamily: fontFamily,
    ),
    headlineLarge: TextStyle(
      fontSize: 42.sp,
      fontWeight: FontWeight.w800,
      color: AppColor.blackColor,
      fontFamily: 'Poppins',
    ),
    headlineMedium: TextStyle(
      fontSize: 30.sp,
      fontWeight: FontWeight.w800,
      color: AppColor.blackColor,
      fontFamily: 'Poppins',
    ),
    headlineSmall: TextStyle(
      fontSize: 26.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.blackColor,
      fontFamily: 'Poppins',
    ),
    titleLarge: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: fontFamily,
    ),
    titleMedium: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: fontFamily,
    ),
    titleSmall: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: fontFamily,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.sp,
      color: Colors.black87,
      fontFamily: fontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.sp,
      color: Colors.black,
      fontFamily: fontFamily,
    ),
    bodySmall: TextStyle(
      fontSize: 14.sp,
      color: Colors.black,
      fontFamily: fontFamily,
    ),
    labelLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: fontFamily,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 50.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.whiteColor,
      fontFamily: fontFamily,
    ),
    headlineLarge: TextStyle(
      fontSize: 42.sp,
      fontWeight: FontWeight.w800,
      color: AppColor.whiteColor,
      fontFamily: 'Poppins',
    ),
    headlineMedium: TextStyle(
      fontSize: 30.sp,
      fontWeight: FontWeight.w800,
      color: AppColor.whiteColor,
      fontFamily: 'Poppins',
    ),
     headlineSmall: TextStyle(
      fontSize: 26.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.whiteColor,
      fontFamily: 'Poppins',
    ),
    titleLarge: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.whiteColor,
      fontFamily: fontFamily,
    ),
    titleMedium: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.whiteColor,
      fontFamily: fontFamily,
    ),
    titleSmall: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontFamily: fontFamily,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.sp,
      color: AppColor.whiteColor,
      fontFamily: fontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.sp,
      color: AppColor.whiteColor,
      fontFamily: fontFamily,
    ),
    bodySmall: TextStyle(
      fontSize: 14.sp,
      color: AppColor.whiteColor,
      fontFamily: fontFamily,
    ),
    labelLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.blackColor,
      fontFamily: fontFamily,
    ),
  );
}


// extension ThemeExtension on BuildContext {
//   TextTheme get text => Theme.of(this).textTheme;

//   ColorScheme get colors => Theme.of(this).colorScheme;

//   ThemeData get theme => Theme.of(this);
// }