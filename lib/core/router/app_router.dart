// core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_feed/core/router/smooth_page_route.dart';
import 'package:news_feed/core/widgets/main_wrapper.dart';
import 'package:news_feed/features/article_detail/presentation/pages/article_detail_page.dart';
import 'package:news_feed/features/news/domain/entities/article_entity.dart';
import 'package:news_feed/features/webview/presentation/pages/web_view_page.dart';
import 'package:news_feed/features/home/presentation/pages/home_page.dart';
import 'package:news_feed/features/search/presentation/pages/search_page.dart';
import 'package:news_feed/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:news_feed/features/bookmarks/presentation/pages/bookmarks_page.dart';
import 'package:news_feed/features/settings/presentation/pages/settings_page.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(
    debugLabel: 'homeShell',
  );
  static final _shellNavigatorSearchKey = GlobalKey<NavigatorState>(
    debugLabel: 'searchShell',
  );
  static final _shellNavigatorBookmarkKey = GlobalKey<NavigatorState>(
    debugLabel: 'bookmarkShell',
  );
  static final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(
    debugLabel: 'settingsShell',
  );

  static final _storage = GetStorage();

  static final GoRouter router = GoRouter(
    initialLocation: '/onboarding',
    navigatorKey: _rootNavigatorKey,

    redirect: (context, state) {
      final bool isOnboardingComplete =
          _storage.read('is_onboarding_complete') ?? false;
      final bool loggingIn = state.matchedLocation == '/onboarding';

      if (isOnboardingComplete && loggingIn) {
        final isFromSettings = state.extra as bool? ?? false;
        if (isFromSettings) return null;

        return '/home';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/onboarding',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final isFromSettings = state.extra as bool? ?? false;
          return SmoothPageRoute(
            key: state.pageKey,
            child: OnboardingPage(isFromSettings: isFromSettings),
          );
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) => SmoothPageRoute(
                  key: state.pageKey,
                  child: const HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSearchKey,
            routes: [
              GoRoute(
                path: '/search',
                pageBuilder: (context, state) => SmoothPageRoute(
                  key: state.pageKey,
                  child: const SearchPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBookmarkKey,
            routes: [
              GoRoute(
                path: '/bookmarks',
                pageBuilder: (context, state) => SmoothPageRoute(
                  key: state.pageKey,
                  child: const BookmarksPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettingsKey,
            routes: [
              GoRoute(
                path: '/settings',
                pageBuilder: (context, state) => SmoothPageRoute(
                  key: state.pageKey,
                  child: const SettingsPage(),
                ),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: '/article-detail',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final article = state.extra as ArticleEntity;
          return SmoothPageRoute(
            key: state.pageKey,
            child: ArticleDetailPage(article: article),
          );
        },
      ),

      GoRoute(
        path: '/webview',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => SmoothPageRoute(
          key: state.pageKey,
          child: WebViewPage(url: state.extra as String),
        ),
      ),
    ],
  );
}
