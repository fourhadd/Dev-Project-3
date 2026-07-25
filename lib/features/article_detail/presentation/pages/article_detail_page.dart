// features/article_detail/presentation/pages/article_detail_page.dart
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_feed/core/constants/app_colors.dart';
import 'package:news_feed/core/constants/app_text_styles.dart';
import 'package:news_feed/features/news/domain/entities/article_entity.dart';
import '../cubit/article_detail_cubit.dart';
import '../widgets/article_image_header.dart';
import '../widgets/article_meta_info.dart';
import '../widgets/article_author_row.dart';
import '../widgets/article_body_content.dart';
import '../widgets/article_bottom_actions.dart';

class ArticleDetailPage extends StatelessWidget {
  final ArticleEntity article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArticleDetailCubit>().loadArticle(article);
    });

    return Scaffold(
      backgroundColor: context.colors.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ArticleImageHeader(
                    imageUrl: article.imageUrl,
                    article: article,
                  ),
                  Transform.translate(
                    offset: Offset(0, -24.h),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24.r),
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ArticleMetaInfo(category: article.category),
                          SizedBox(height: 16.h),
                          Text(
                            article.title,
                            style: AppTextStyles.headlineLarge.copyWith(
                              color: context.colors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ArticleAuthorRow(article: article),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Divider(
                              color: context.colors.divider,
                              thickness: 1.h,
                            ),
                          ),
                          ArticleBodyContent(content: article.content),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ArticleBottomActions(url: article.url),
        ],
      ),
    );
  }
}
