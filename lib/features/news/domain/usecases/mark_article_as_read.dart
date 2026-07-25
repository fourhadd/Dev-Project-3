// features/news/domain/usecases/mark_article_as_read.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/news_repository.dart';

class MarkArticleAsRead implements UseCase<void, String> {
  final NewsRepository repository;

  MarkArticleAsRead(this.repository);

  @override
  Future<Either<Failure, void>> call(String articleId) async {
    return await repository.markArticleAsRead(articleId);
  }
}
