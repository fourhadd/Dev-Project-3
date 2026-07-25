// features/article_detail/presentation/widgets/article_image_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:news_feed/core/constants/app_colors.dart';
import 'package:news_feed/features/news/domain/entities/article_entity.dart';
import 'package:news_feed/features/news/data/models/article_model.dart';
import 'package:news_feed/features/news/data/models/source_model.dart';
import '../../../../features/bookmarks/presentation/cubit/bookmarks_cubit.dart';
import '../../../../features/settings/presentation/cubit/settings_cubit.dart';
import '../cubit/article_detail_cubit.dart';
import 'article_shimmer.dart';

class ArticleImageHeader extends StatelessWidget {
  final String? imageUrl;
  final ArticleEntity article;

  const ArticleImageHeader({super.key, this.imageUrl, required this.article});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final bookmarkCubit = context.watch<BookmarkCubit>();
    final isSaved = bookmarkCubit.isBookmarked(article.url);

    return Stack(
      children: [
        imageUrl != null && imageUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                height: 320.h,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => ArticleShimmer(
                  width: double.infinity,
                  height: 320.h,
                  borderRadius: BorderRadius.zero,
                ),
                errorWidget: (context, url, error) => Container(
                  height: 320.h,
                  color: colors.readState,
                  child: Icon(Icons.broken_image, size: 40.r),
                ),
              )
            : Container(
                height: 320.h,
                color: colors.readState,
                child: Icon(Icons.image, size: 40.r),
              ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Geri Düyməsi
                _CircleIconButton(
                  icon: Icons.arrow_back_ios_new,
                  onPressed: () => context.pop(),
                ),
                Row(
                  children: [
                    _CircleIconButton(
                      icon: Icons.text_fields_rounded,
                      onPressed: () {
                        final currentScale = context
                            .read<SettingsCubit>()
                            .state
                            .fontSizeScale;
                        final nextScale = currentScale >= 1.4
                            ? 0.8
                            : currentScale + 0.2;
                        context.read<SettingsCubit>().updateFontScale(
                          nextScale,
                        );
                      },
                    ),
                    SizedBox(width: 12.w),
                    _CircleIconButton(
                      icon: isSaved
                          ? Icons.bookmark
                          : Icons.bookmark_border_rounded,
                      iconColor: isSaved ? colors.primary : Colors.white,
                      onPressed: () {
                        final model = article is ArticleModel
                            ? article as ArticleModel
                            : ArticleModel(
                                id: (article is ArticleModel)
                                    ? (article as ArticleModel).id
                                    : '',
                                title: article.title,
                                content: (article is ArticleModel)
                                    ? (article as ArticleModel).content
                                    : '',
                                imageUrl: article.imageUrl,
                                source: article.source is SourceModel
                                    ? article.source as SourceModel
                                    : SourceModel(
                                        id: article.source.id,
                                        name: article.source.name,
                                      ),
                                author: (article is ArticleModel)
                                    ? (article as ArticleModel).author
                                    : null,
                                publishedAt: article.publishedAt,
                                category: (article is ArticleModel)
                                    ? (article as ArticleModel).category
                                    : 'General',
                                url: article.url,
                              );

                        context.read<BookmarkCubit>().toggleBookmark(model);
                        context
                            .read<ArticleDetailCubit>()
                            .toggleBookmarkStatus();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;

  const _CircleIconButton({
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor ?? Colors.white, size: 20.r),
        onPressed: onPressed,
      ),
    );
  }
}
