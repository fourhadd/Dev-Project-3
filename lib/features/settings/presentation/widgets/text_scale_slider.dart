// features/settings/presentation/widgets/text_scale_slider.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_feed/features/settings/presentation/cubit/settings_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../cubit/settings_cubit.dart';

class TextScaleSlider extends StatelessWidget {
  const TextScaleSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, top: 12.h, right: 16.w),
          child: Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.text_fields,
                  color: colors.primary,
                  size: 20.r,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Mətn ölçüsü',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (prev, curr) => prev.fontSizeScale != curr.fontSizeScale,
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Text(
                    'A',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      value: state.fontSizeScale,
                      min: 0.8,
                      max: 1.4,
                      divisions: 3,
                      activeColor: colors.primary,
                      inactiveColor: colors.readState,
                      onChanged: (val) =>
                          context.read<SettingsCubit>().updateFontScale(val),
                    ),
                  ),
                  Text(
                    'A',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: colors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
