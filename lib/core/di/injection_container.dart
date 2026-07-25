// core/di/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_feed/core/theme/theme_cubit.dart';
import 'package:news_feed/features/bookmarks/presentation/cubit/bookmarks_cubit.dart';
import 'package:news_feed/features/home/presentation/cubit/home_cubit.dart';
import 'package:news_feed/features/news/data/datasources/news_local_datasource.dart';
import 'package:news_feed/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_feed/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_feed/features/news/domain/repositories/news_repository.dart';
import 'package:news_feed/features/news/domain/usecases/get_articles_by_category.dart';
import 'package:news_feed/features/news/domain/usecases/get_bookmarked_articles.dart';
import 'package:news_feed/features/news/domain/usecases/get_top_headlines.dart';
import 'package:news_feed/features/news/domain/usecases/is_article_read.dart';
import 'package:news_feed/features/news/domain/usecases/mark_article_as_read.dart';
import 'package:news_feed/features/news/domain/usecases/search_articles.dart';
import 'package:news_feed/features/news/domain/usecases/toggle_bookmark.dart';
import 'package:news_feed/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:news_feed/features/article_detail/presentation/cubit/article_detail_cubit.dart';
import 'package:news_feed/features/search/presentation/cubit/search_cubit.dart';
import 'package:news_feed/features/settings/presentation/cubit/settings_cubit.dart';
import '../network/secure_storage_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => GetStorage());
  sl.registerLazySingleton(() => Connectivity());

  // Core
  sl.registerLazySingleton(() => SecureStorageService(sl()));
  sl.registerFactory(() => ThemeCubit(sl()));

  // Data sources
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      connectivity: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetTopHeadlines(sl()));
  sl.registerLazySingleton(() => GetArticlesByCategory(sl()));
  sl.registerLazySingleton(() => SearchArticles(sl()));
  sl.registerLazySingleton(() => ToggleBookmark(sl()));
  sl.registerLazySingleton(() => GetBookmarkedArticles(sl()));
  sl.registerLazySingleton(() => MarkArticleAsRead(sl()));
  sl.registerLazySingleton(() => IsArticleRead(sl()));

  // Cubits
  sl.registerFactory(() => OnboardingCubit(sl<GetStorage>(), sl<HomeCubit>()));
  sl.registerFactory(
    () => HomeCubit(getArticlesByCategory: sl<GetArticlesByCategory>()),
  );

  sl.registerFactory(
    () => ArticleDetailCubit(
      toggleBookmark: sl(),
      getBookmarkedArticles: sl(),
      markArticleAsRead: sl(),
      isArticleRead: sl(),
    ),
  );
  sl.registerFactory(() => SearchCubit(searchArticles: sl()));
  sl.registerFactory(() => BookmarkCubit());
  sl.registerFactory(() => SettingsCubit());
}
