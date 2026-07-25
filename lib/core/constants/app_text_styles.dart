// core/constants/app_text_styles.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle get headlineLarge =>
      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700, height: 1.3);

  static TextStyle get headlineMedium =>
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, height: 1.4);

  static TextStyle get bodyLarge =>
      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, height: 1.6);

  static TextStyle get bodyMedium =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, height: 1.4);

  static TextStyle get labelSmall =>
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, height: 1.2);
}
