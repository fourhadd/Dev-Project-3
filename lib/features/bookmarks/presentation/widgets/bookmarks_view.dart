// features/bookmarks/presentation/widgets/bookmarks_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../home/presentation/widgets/news_card_tile.dart';
import '../cubit/bookmarks_cubit.dart';
import '../cubit/bookmarks_state.dart';
import 'bookmark_shimmer_list.dart';

class BookmarksView extends StatelessWidget {
  const BookmarksView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocBuilder<BookmarkCubit, BookmarkState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is BookmarkLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BookmarkShimmerList(),
          );
        }

        if (state is BookmarkSuccess) {
          final articles = state.articles;

          if (articles.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  AppStrings.bookmarksEmpty,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: colors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: articles.length,

            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              return NewsCardTile(
                key: ValueKey(articles[index].url),
                article: articles[index],
              );
            },
          );
        }

        if (state is BookmarkError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                state.message,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
