// features/onboarding/presentation/widgets/interest_item_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

class InterestItemTile extends StatelessWidget {
  final String category;

  const InterestItemTile({super.key, required this.category});

  String _getLocalizedName(String cat) {
    switch (cat) {
      case 'Business':
        return 'Biznes';
      case 'Technology':
        return 'Texnologiya';
      case 'Sport':
        return 'İdman';
      case 'Health':
        return 'Səhiyyə';
      case 'Entertainment':
        return 'Əyləncə';
      case 'Science':
        return 'Elm';
      case 'Politics':
        return 'Siyasət';
      case 'World':
        return 'Dünya';
      default:
        return cat;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final localizedName = _getLocalizedName(category);

    return BlocSelector<OnboardingCubit, OnboardingState, bool>(
      selector: (state) => state.selectedCategories.contains(category),
      builder: (context, isSelected) {
        return InkWell(
          onTap: () => context.read<OnboardingCubit>().toggleCategory(category),
          borderRadius: BorderRadius.circular(12.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: isSelected ? colors.primary : colors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected
                    ? colors.primary
                    : (colors.divider ?? Colors.transparent),
                width: 1.5,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    localizedName,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: isSelected ? Colors.white : colors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isSelected) ...[
                  SizedBox(width: 6.w),
                  const Icon(Icons.check_circle, color: Colors.white, size: 18),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
