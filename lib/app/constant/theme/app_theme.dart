import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';
import 'app_text_theme.dart';
import 'app_theme_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: AppColor.myThemeColor,
    primaryColor: AppColor.primaryColor,
    textTheme: AppTextTheme.lightTextTheme,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Poppins",

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),


    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade100,
      hintStyle: const TextStyle(color: AppColor.grey),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide:const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: const BorderSide(color: AppColor.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide:const BorderSide(color: Colors.red, width: 2),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    ),

    colorScheme: ColorScheme.light(
      primary: AppColor.primaryColor,
      secondary: AppColor.primaryColor,
      surface: Colors.white,
      error: Colors.red.shade600,
      surfaceContainer: AppColor.primaryColor.withOpacity(0.7),
    ),

    extensions: [
      AppThemeColors(
        inputBg: Colors.grey.shade100,
        cardBg: Colors.white,
        border: Color(0xffE0E0E0),
        divider: Color(0xffEEEEEE),
        success: Colors.green,
        warning: Colors.orange,
        countryCodeBg: Color(0xffEFEFEF),
        iconColor: AppColor.blackColor,
        iconBg: Colors.black,
        black: Colors.black,
      ),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: AppColor.myThemeColor,
    primaryColor: AppColor.primaryColor,
    textTheme: AppTextTheme.darkTextTheme,
    scaffoldBackgroundColor: AppColor.darkBGColor,
    fontFamily: "Poppins",

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.darkBGColor,
      foregroundColor: AppColor.whiteColor,
      elevation: 0,
      centerTitle: true,
    ),



    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.darkGrey,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide:const BorderSide(color: AppColor.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        foregroundColor: AppColor.blackColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    ),

    colorScheme: const ColorScheme.dark(
      primary: AppColor.primaryColor,
      secondary: AppColor.primaryColor,
      surface: AppColor.darkBGColor,
      error: Colors.red,
      surfaceContainer: AppColor.darkCardBgColor,
    ),

    extensions: const [
      AppThemeColors(
        inputBg: Color(0xFF3A3A3A),
        cardBg: Color(0xff222222),
        border: Color(0xff353535),
        divider: Color(0xff404040),
        success: Colors.green,
        warning: Colors.orange,
        countryCodeBg: Color(0xff2B2B2B),
        iconColor: AppColor.whiteColor,
        iconBg: Colors.white,
        black: Colors.white
      ),
    ],
  );
}
