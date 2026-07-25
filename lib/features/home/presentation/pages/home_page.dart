// features/home/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_feed/features/home/presentation/widgets/news_category_tabs.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../widgets/news_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: colors.textPrimary),
          onPressed: () {},
        ),
        title: Text(
          AppStrings.appName,
          style: AppTextStyles.headlineLarge.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: colors.textPrimary),
            onPressed: () {
              context.go('/search');
            },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            const NewsCategoryTabs(),
            SizedBox(height: 12.h),
            const Expanded(child: NewsListView()),
          ],
        ),
      ),
    );
  }
}
