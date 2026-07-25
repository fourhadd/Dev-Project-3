// features/news/domain/usecases/toggle_bookmark.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/article_entity.dart';
import '../repositories/news_repository.dart';

class ToggleBookmark implements UseCase<void, ArticleEntity> {
  final NewsRepository repository;

  ToggleBookmark(this.repository);

  @override
  Future<Either<Failure, void>> call(ArticleEntity article) async {
    return await repository.toggleBookmark(article);
  }
}
