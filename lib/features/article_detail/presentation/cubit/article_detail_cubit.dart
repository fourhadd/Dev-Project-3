// features/article_detail/presentation/cubit/article_detail_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../news/domain/entities/article_entity.dart';
import '../../../news/domain/usecases/toggle_bookmark.dart';
import '../../../news/domain/usecases/get_bookmarked_articles.dart';
import '../../../news/domain/usecases/mark_article_as_read.dart';
import '../../../news/domain/usecases/is_article_read.dart';
import 'article_detail_state.dart';

class ArticleDetailCubit extends Cubit<ArticleDetailState> {
  final ToggleBookmark toggleBookmark;
  final GetBookmarkedArticles getBookmarkedArticles;
  final MarkArticleAsRead markArticleAsRead;
  final IsArticleRead isArticleRead;

  late ArticleEntity article;

  ArticleDetailCubit({
    required this.toggleBookmark,
    required this.getBookmarkedArticles,
    required this.markArticleAsRead,
    required this.isArticleRead,
  }) : super(const ArticleDetailState());

  void loadArticle(ArticleEntity articleEntity) async {
    article = articleEntity;

    await markArticleAsRead(article.id);

    _checkStatus();
  }

  Future<void> _checkStatus() async {
    bool bookmarked = false;
    bool read = false;

    final bookmarksResult = await getBookmarkedArticles(NoParams());
    bookmarksResult.fold(
      (failure) => bookmarked = false,
      (bookmarks) => bookmarked = bookmarks.any((e) => e.id == article.id),
    );

    final readResult = await isArticleRead(article.id);
    readResult.fold((failure) => read = false, (isRead) => read = isRead);

    emit(state.copyWith(isBookmarked: bookmarked, isRead: read));
  }

  Future<void> toggleBookmarkStatus() async {
    final result = await toggleBookmark(article);
    result.fold((failure) => null, (_) => _checkStatus());
  }

  void updateFontScale(double newScale) {
    emit(state.copyWith(fontScale: newScale));
  }
}
