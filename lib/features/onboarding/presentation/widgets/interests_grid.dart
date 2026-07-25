// features/onboarding/presentation/widgets/interests_grid.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_feed/features/onboarding/presentation/widgets/interest_item_tile.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

class InterestsGrid extends StatelessWidget {
  const InterestsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OnboardingCubit, OnboardingState, List<String>>(
      selector: (state) => state.availableCategories,
      builder: (context, availableCategories) {
        return GridView.builder(
          itemCount: availableCategories.length,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 2.3,
          ),
          itemBuilder: (context, index) {
            final category = availableCategories[index];
            return InterestItemTile(category: category);
          },
        );
      },
    );
  }
}
