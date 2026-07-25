// features/home/presentation/widgets/news_card_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import 'package:news_feed/features/news/data/models/article_model.dart';
import '../../../bookmarks/presentation/cubit/bookmarks_cubit.dart';
import '../../../bookmarks/presentation/cubit/bookmarks_state.dart';
import 'image_shimmer_placeholder.dart';

class NewsCardTile extends StatelessWidget {
  final ArticleModel article;

  const NewsCardTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      child: GestureDetector(
        onTap: () {
          context.push('/article-detail', extra: article);
        },
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    child: Image.network(
                      article.imageUrl ?? 'https://via.placeholder.com/400x200',
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) return child;
                            if (frame == null) {
                              return ImageShimmerPlaceholder(
                                height: 200.h,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.r),
                                ),
                              );
                            }
                            return AnimatedOpacity(
                              opacity: 1.0,
                              duration: const Duration(milliseconds: 300),
                              child: child,
                            );
                          },
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200.h,
                        color: colors.background,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.broken_image,
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12.h,
                    left: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primary.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        article.category.toUpperCase(),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${article.source.name}  •  ${_formatDate(article.publishedAt)}',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: colors.textSecondary,
                              fontSize: 11.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        BlocBuilder<BookmarkCubit, BookmarkState>(
                          builder: (context, state) {
                            final isSaved = context
                                .read<BookmarkCubit>()
                                .isBookmarked(article.url);

                            return GestureDetector(
                              onTap: () {
                                context.read<BookmarkCubit>().toggleBookmark(
                                  article,
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(4.w),
                                child: Icon(
                                  isSaved
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: isSaved
                                      ? colors.primary
                                      : colors.textSecondary,
                                  size: 22.sp,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} dəq əvvəl';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} saat əvvəl';
    } else {
      return '${date.day}.${date.month}.${date.year}';
    }
  }
}
