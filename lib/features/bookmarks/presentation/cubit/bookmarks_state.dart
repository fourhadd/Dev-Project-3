// features/bookmarks/presentation/cubit/bookmarks_state.dart
import 'package:news_feed/features/news/data/models/article_model.dart';

abstract class BookmarkState {
  const BookmarkState();
}

class BookmarkInitial extends BookmarkState {}

class BookmarkLoading extends BookmarkState {}

class BookmarkSuccess extends BookmarkState {
  final List<ArticleModel> articles;
  const BookmarkSuccess(this.articles);
}

class BookmarkError extends BookmarkState {
  final String message;
  const BookmarkError(this.message);
}
