// features/news/domain/usecases/get_bookmarked_articles.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/article_entity.dart';
import '../repositories/news_repository.dart';

class GetBookmarkedArticles implements UseCase<List<ArticleEntity>, NoParams> {
  final NewsRepository repository;

  GetBookmarkedArticles(this.repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(NoParams params) async {
    return await repository.getBookmarkedArticles();
  }
}
