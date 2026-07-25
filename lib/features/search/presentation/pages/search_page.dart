// features/search/presentation/pages/search_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';
import '../widgets/search_input_field.dart';
import '../widgets/search_initial_suggestions.dart';
import '../widgets/search_results_list.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              const SearchInputField(),
              SizedBox(height: 24.h),

              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: colors.primary),
                      );
                    } else if (state is SearchSuccess) {
                      if (state.articles.isEmpty) {
                        return const Center(
                          child: Text('Heç bir nəticə tapılmadı.'),
                        );
                      }
                      return SearchResultsList(articles: state.articles);
                    } else if (state is SearchError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: TextStyle(color: colors.textPrimary),
                        ),
                      );
                    }

                    return const SearchInitialSuggestions();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
