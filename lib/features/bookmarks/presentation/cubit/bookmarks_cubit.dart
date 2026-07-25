// features/bookmarks/presentation/cubit/bookmarks_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_feed/features/bookmarks/presentation/cubit/bookmarks_state.dart';
import 'package:news_feed/features/news/data/models/article_model.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'saved_bookmarks_key';
  List<ArticleModel> _bookmarkedArticles = [];

  BookmarkCubit() : super(BookmarkInitial()) {
    loadBookmarks();
  }

  List<ArticleModel> get bookmarkedArticles => _bookmarkedArticles;

  void loadBookmarks() {
    emit(BookmarkLoading());
    final List<dynamic>? storedList = _storage.read<List<dynamic>>(_storageKey);

    if (storedList != null) {
      _bookmarkedArticles = storedList.map((item) {
        final jsonMap = item as Map<String, dynamic>;

        return ArticleModel.fromJson(jsonMap, jsonMap['category'] ?? '');
      }).toList();
    } else {
      _bookmarkedArticles = [];
    }
    emit(BookmarkSuccess(_bookmarkedArticles));
  }

  void toggleBookmark(ArticleModel article) {
    emit(BookmarkLoading());

    final isExist = _bookmarkedArticles.any(
      (element) => element.url == article.url,
    );

    if (isExist) {
      _bookmarkedArticles.removeWhere((element) => element.url == article.url);
    } else {
      _bookmarkedArticles.insert(0, article);
    }

    final jsonList = _bookmarkedArticles.map((e) => e.toJson()).toList();
    _storage.write(_storageKey, jsonList);

    emit(BookmarkSuccess(_bookmarkedArticles));
  }

  bool isBookmarked(String url) {
    return _bookmarkedArticles.any((element) => element.url == url);
  }
}
