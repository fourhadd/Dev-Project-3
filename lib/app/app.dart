// app/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_feed/core/router/app_router.dart';
import 'package:news_feed/features/article_detail/presentation/cubit/article_detail_cubit.dart';
import 'package:news_feed/features/bookmarks/presentation/cubit/bookmarks_cubit.dart';
import 'package:news_feed/features/home/presentation/cubit/home_cubit.dart';
import 'package:news_feed/features/search/presentation/cubit/search_cubit.dart';
import 'package:news_feed/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:news_feed/features/settings/presentation/cubit/settings_state.dart';
import '../core/theme/app_theme.dart';
import '../core/di/injection_container.dart';
import '../features/onboarding/presentation/cubit/onboarding_cubit.dart';

class NewFeedsApp extends StatelessWidget {
  const NewFeedsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(create: (context) => sl<SettingsCubit>()),
        BlocProvider<OnboardingCubit>(
          create: (context) => sl<OnboardingCubit>(),
        ),
        BlocProvider<HomeCubit>(create: (context) => sl<HomeCubit>()),
        BlocProvider<ArticleDetailCubit>(
          create: (context) => sl<ArticleDetailCubit>(),
        ),
        BlocProvider<SearchCubit>(
          create: (context) => sl<SearchCubit>()..loadRecommendations(),
        ),
        BlocProvider<BookmarkCubit>(create: (context) => sl<BookmarkCubit>()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (prev, curr) =>
            prev.themeMode != curr.themeMode ||
            prev.fontSizeScale != curr.fontSizeScale,
        builder: (context, settingsState) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            fontSizeResolver: (fontSize, instance) =>
                fontSize * settingsState.fontSizeScale,
            builder: (context, child) {
              return MaterialApp.router(
                title: 'NewsFeed',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: settingsState.themeMode,
                routerConfig: AppRouter.router,
                builder: (context, widget) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: TextScaler.linear(
                        settingsState.fontSizeScale,
                      ),
                    ),
                    child: widget!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
