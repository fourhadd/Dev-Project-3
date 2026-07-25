// features/news/data/repositories/news_repository_impl.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/article_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_local_datasource.dart';
import '../datasources/news_remote_datasource.dart';
import '../models/article_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final Connectivity connectivity;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });

  Future<bool> _isConnected() async {
    final result = await connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticlesByCategory(
    String category,
  ) async {
    if (await _isConnected()) {
      try {
        final remoteArticles = await remoteDataSource.getArticlesByCategory(
          category,
        );
        return Right(remoteArticles);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> searchArticles(
    String query,
  ) async {
    if (await _isConnected()) {
      try {
        final remoteResults = await remoteDataSource.searchArticles(query);
        return Right(remoteResults);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getBookmarkedArticles() async {
    try {
      final bookmarks = await localDataSource.getBookmarks();
      return Right(bookmarks);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> toggleBookmark(ArticleEntity article) async {
    try {
      final bookmarks = await localDataSource.getBookmarks();
      final model = ArticleModel.fromEntity(article);

      if (bookmarks.any((item) => item.id == article.id)) {
        await localDataSource.removeBookmark(article.id);
      } else {
        await localDataSource.cacheBookmark(model);
      }
      return const Right(null);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> markArticleAsRead(String articleId) async {
    try {
      await localDataSource.markAsRead(articleId);
      return const Right(null);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isArticleRead(String articleId) async {
    try {
      final isRead = await localDataSource.isArticleRead(articleId);
      return Right(isRead);
    } on CacheException {
      return const Left(CacheFailure());
    }
  }
}
