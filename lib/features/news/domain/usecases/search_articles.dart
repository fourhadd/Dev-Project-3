// features/news/domain/usecases/search_articles.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/article_entity.dart';
import '../repositories/news_repository.dart';

class SearchArticles implements UseCase<List<ArticleEntity>, String> {
  final NewsRepository repository;

  SearchArticles(this.repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(String query) async {
    return await repository.searchArticles(query);
  }
}
