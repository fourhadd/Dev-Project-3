// features/bookmarks/presentation/pages/bookmarks_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../widgets/bookmarks_view.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        surfaceTintColor: colors.background,
        leading: IconButton(
          icon: Icon(Icons.menu, color: colors.textPrimary, size: 24.sp),
          onPressed: () {},
        ),
        title: Text(
          AppStrings.appName,
          style: TextStyle(
            color: colors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: colors.textPrimary,
              size: 24.sp,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  Text(
                    'Saxlanılanlar',
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            const Expanded(child: BookmarksView()),
          ],
        ),
      ),
    );
  }
}
