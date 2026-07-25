// features/settings/presentation/widgets/theme_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

class ThemeTile extends StatelessWidget {
  const ThemeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (prev, curr) => prev.themeMode != curr.themeMode,
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          child: ListTile(
            leading: Container(
              width: 36.r,
              height: 36.r,
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.dark_mode, color: colors.primary, size: 20.r),
            ),
            title: Text(
              'Görünüş',
              style: AppTextStyles.bodyLarge.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Switch.adaptive(
              value: state.isDarkMode,
              activeThumbColor: Colors.white,
              activeTrackColor: colors.primary,
              onChanged: (val) =>
                  context.read<SettingsCubit>().toggleTheme(val),
            ),
          ),
        );
      },
    );
  }
}
