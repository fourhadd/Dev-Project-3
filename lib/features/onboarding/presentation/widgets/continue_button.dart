// features/onboarding/presentation/widgets/continue_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

class ContinueButton extends StatelessWidget {
  final bool isFromSettings;

  const ContinueButton({super.key, this.isFromSettings = false});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.isSaved != current.isSaved && current.isSaved,
      listener: (context, state) {
        if (isFromSettings) {
          context.pop();
        } else {

          GetStorage().write('is_onboarding_seen', true);
          context.go('/home');
        }
      },
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        buildWhen: (previous, current) =>
            (previous.selectedCategories.isEmpty &&
                current.selectedCategories.isNotEmpty) ||
            (previous.selectedCategories.isNotEmpty &&
                current.selectedCategories.isEmpty),
        builder: (context, state) {
          final isEnabled = state.selectedCategories.isNotEmpty;

          return SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: isEnabled
                  ? () => context.read<OnboardingCubit>().savePreferences()
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                disabledBackgroundColor: colors.primary.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: Text(
                isFromSettings ? 'Yadda saxla' : AppStrings.continueButton,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: isEnabled ? Colors.white : Colors.white60,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
