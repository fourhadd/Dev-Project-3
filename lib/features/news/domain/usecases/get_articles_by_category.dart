// features/news/domain/usecases/get_articles_by_category.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/article_entity.dart';
import '../repositories/news_repository.dart';

class GetArticlesByCategory implements UseCase<List<ArticleEntity>, String> {
  final NewsRepository repository;

  GetArticlesByCategory(this.repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(String category) async {
    return await repository.getArticlesByCategory(category);
  }
}
