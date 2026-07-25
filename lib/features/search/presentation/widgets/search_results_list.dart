// features/search/presentation/widgets/search_results_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_feed/features/news/domain/entities/article_entity.dart';
import 'search_news_card_tile.dart';

class SearchResultsList extends StatelessWidget {
  final List<ArticleEntity> articles;

  const SearchResultsList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: articles.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return SearchNewsCardTile(article: articles[index]);
      },
    );
  }
}
