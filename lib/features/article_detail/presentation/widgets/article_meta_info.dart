// features/article_detail/presentation/widgets/article_meta_info.dart
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_feed/core/constants/app_colors.dart';
import 'package:news_feed/core/constants/app_text_styles.dart';
import 'package:news_feed/core/constants/app_strings.dart';

class ArticleMetaInfo extends StatelessWidget {
  final String category;

  const ArticleMetaInfo({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            category.toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          '3 ${AppStrings.readingTime}',
          style: AppTextStyles.labelSmall.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
