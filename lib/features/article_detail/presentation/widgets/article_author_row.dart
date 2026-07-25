// features/article_detail/presentation/widgets/article_author_row.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:news_feed/core/constants/app_colors.dart';
import 'package:news_feed/core/constants/app_text_styles.dart';
import 'package:news_feed/features/news/domain/entities/article_entity.dart';

class ArticleAuthorRow extends StatelessWidget {
  final ArticleEntity article;

  const ArticleAuthorRow({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat(
      'dd.MM.yyyy',
    ).format(article.publishedAt);

    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundColor: context.colors.readState,
          backgroundImage: const NetworkImage(
            'https://i.imgur.com/Bx9Fsc8.jpeg',
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.author ?? 'Naməlum Müəllif',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colors.textPrimary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                '${article.source.name} • $formattedDate',
                style: AppTextStyles.labelSmall.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
