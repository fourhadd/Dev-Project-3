// features/home/presentation/widgets/news_list_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_feed/core/constants/app_colors.dart';
import 'package:news_feed/core/widgets/custom_error_widget.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'news_card_tile.dart';
import 'news_list_shimmer.dart';

class NewsListView extends StatelessWidget {
  const NewsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.initial ||
            state.status == HomeStatus.loading) {
          return const NewsListShimmer();
        }

        if (state.status == HomeStatus.failure && state.articles.isEmpty) {
          return CustomErrorWidget(
            errorMessage: 'Gözlənilməz bir xəta yarandı.',
            onRetry: () => context.read<HomeCubit>().fetchNews(),
          );
        }

        if (state.status == HomeStatus.success && state.articles.isEmpty) {
          return Center(
            child: Text(
              'Xəbər tapılmadı.',
              style: TextStyle(color: colors.textSecondary, fontSize: 14.sp),
            ),
          );
        }

        return RefreshIndicator.adaptive(
          onRefresh: () => context.read<HomeCubit>().fetchNews(),
          color: colors.primary,
          child: ListView.builder(
            itemCount: state.articles.length,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 16.h),
            itemBuilder: (context, index) {
              return NewsCardTile(article: state.articles[index]);
            },
          ),
        );
      },
    );
  }
}
