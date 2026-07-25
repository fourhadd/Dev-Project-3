// features/search/presentation/widgets/search_news_card_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'package:news_feed/features/news/domain/entities/article_entity.dart';
import '../../../home/presentation/widgets/image_shimmer_placeholder.dart';
import '../cubit/search_cubit.dart';

class SearchNewsCardTile extends StatelessWidget {
  final ArticleEntity article;

  const SearchNewsCardTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: () {
        context.read<SearchCubit>().clearSearch();
        context.push('/article-detail', extra: article);
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                width: 80.w,
                height: 80.w,
                color: colors.background,
                child: Image.network(
                  article.imageUrl ?? 'https://via.placeholder.com/80',
                  fit: BoxFit.cover,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) return child;
                        if (frame == null) {
                          return ImageShimmerPlaceholder(
                            height: 80.w,
                            borderRadius: BorderRadius.circular(10.r),
                          );
                        }
                        return AnimatedOpacity(
                          opacity: 1.0,
                          duration: const Duration(milliseconds: 300),
                          child: child,
                        );
                      },
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image, color: colors.textSecondary),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    article.title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(
                        Icons.public,
                        size: 14.sp,
                        color: colors.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          article.source.name,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: colors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _formatDate(article.publishedAt),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inMinutes < 60) return '${difference.inMinutes} dəq əvvəl';
    if (difference.inHours < 24) return '${difference.inHours} saat əvvəl';
    return '${date.day}.${date.month}.${date.year}';
  }
}
