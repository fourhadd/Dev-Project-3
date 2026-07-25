// features/search/presentation/widgets/search_initial_suggestions.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import 'search_news_card_tile.dart';

class SearchInitialSuggestions extends StatelessWidget {
  const SearchInitialSuggestions({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final cubit = context.read<SearchCubit>();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SON AXTARIŞLAR',
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 12.h),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (cubit.recentSearches.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Text(
                    'Hələ bir axtarış edilməyib.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                );
              }
              return Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: cubit.recentSearches.map((search) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(20.r),
                    onTap: () {
                      cubit.onRecentSearchClicked(search);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: colors.divider ?? Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.history,
                            size: 14.sp,
                            color: colors.textSecondary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            search,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: colors.textPrimary,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          SizedBox(height: 28.h),
          Text(
            'TÖVSİYƏ EDİLƏN XƏBƏRLƏR',
            style: AppTextStyles.labelSmall.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (cubit.recommendedArticles.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: CircularProgressIndicator(color: colors.primary),
                  ),
                );
              }
              return Column(
                children: cubit.recommendedArticles.map((article) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: SearchNewsCardTile(article: article),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
