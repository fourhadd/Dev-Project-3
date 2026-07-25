// features/news/domain/usecases/get_top_headlines.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/article_entity.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlines implements UseCase<List<ArticleEntity>, NoParams> {
  final NewsRepository repository;

  GetTopHeadlines(this.repository);

  @override
  Future<Either<Failure, List<ArticleEntity>>> call(NoParams params) async {
    return await repository.getArticlesByCategory('news');
  }
}
