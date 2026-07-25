// features/search/presentation/widgets/search_input_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

class SearchInputField extends StatefulWidget {
  const SearchInputField({super.key});

  @override
  State<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocListener<SearchCubit, SearchState>(
      listener: (context, state) {
        final cubit = context.read<SearchCubit>();

        if (_controller.text != cubit.currentSearchQuery) {
          _controller.text = cubit.currentSearchQuery;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          );
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                onChanged: (value) =>
                    context.read<SearchCubit>().onSearchTextChanged(value),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: colors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: 'Xəbər, mövzu və ya açar söz axtar...',
                  hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: colors.textSecondary,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: colors.textSecondary,
                    size: 22.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
