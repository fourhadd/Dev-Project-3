// features/news/domain/repositories/news_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/article_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<ArticleEntity>>> getArticlesByCategory(
    String category,
  );
  Future<Either<Failure, List<ArticleEntity>>> searchArticles(String query);
  Future<Either<Failure, List<ArticleEntity>>> getBookmarkedArticles();
  Future<Either<Failure, void>> toggleBookmark(ArticleEntity article);
  Future<Either<Failure, void>> markArticleAsRead(String articleId);
  Future<Either<Failure, bool>> isArticleRead(String articleId);
}
