// core/constants/app_radius.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppRadius {
  static double get card => 12.r;
  static double get chip => 8.r;
  static double get button => 12.r;

  static BorderRadius get cardRadius => BorderRadius.circular(card);
  static BorderRadius get chipRadius => BorderRadius.circular(chip);
  static BorderRadius get buttonRadius => BorderRadius.circular(button);
}
