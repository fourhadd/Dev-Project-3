// features/news/domain/usecases/is_article_read.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/news_repository.dart';

class IsArticleRead implements UseCase<bool, String> {
  final NewsRepository repository;

  const IsArticleRead(this.repository);

  @override
  Future<Either<Failure, bool>> call(String articleId) async {
    return await repository.isArticleRead(articleId);
  }
}
