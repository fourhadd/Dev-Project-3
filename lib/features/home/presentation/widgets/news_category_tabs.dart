// features/home/presentation/widgets/news_category_tabs.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class NewsCategoryTabs extends StatelessWidget {
  const NewsCategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final Map<String, String> localizedTabs = {
      'All': 'Top Headlines',
      'Technology': 'Tech',
      'Sport': 'Sport',
      'Business': 'Business',
      'Politics': 'Politics',
      'World': 'World',
      'Science': 'Science',
      'Fashion': 'Fashion',
    };

    final categories = [
      'All',
      'Business',
      'Technology',
      'Sport',
      'Politics',
      'World',
      'Science',
      'Fashion',
    ];

    return SizedBox(
      height: 38.h,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          final displayName = localizedTabs[category] ?? category;
          return BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                previous.selectedCategory != current.selectedCategory,
            builder: (context, state) {
              final isSelected = state.selectedCategory == category;

              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: InkWell(
                  onTap: () {
                    context.read<HomeCubit>().changeCategory(category);
                  },
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    decoration: BoxDecoration(
                      color: isSelected ? colors.primary : colors.surface,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: isSelected
                            ? colors.primary
                            : (colors.divider ?? Colors.transparent),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      displayName,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isSelected ? Colors.white : colors.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
