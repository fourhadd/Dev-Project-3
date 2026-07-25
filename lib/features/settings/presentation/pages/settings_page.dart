// features/settings/presentation/pages/settings_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../widgets/theme_tile.dart';
import '../widgets/text_scale_slider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
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
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              'Settings',
              style: AppTextStyles.headlineLarge.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Material(
              color: colors.surface,
              borderRadius: BorderRadius.circular(16.r),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 36.r,
                      height: 36.r,
                      decoration: BoxDecoration(
                        color: colors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: colors.primary,
                        size: 20.r,
                      ),
                    ),
                    title: Text(
                      'Maraqlar',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 14.r,
                      color: colors.textSecondary,
                    ),
                    onTap: () {
                      context.push('/onboarding', extra: true);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Material(
              color: colors.surface,
              borderRadius: BorderRadius.circular(16.r),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ThemeTile(),
                  Divider(
                    height: 1,
                    indent: 56.w,
                    endIndent: 16.w,
                    color:
                        colors.divider ??
                        colors.readState.withValues(alpha: 0.3),
                  ),
                  const TextScaleSlider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
