// features/news/data/datasources/news_local_datasource.dart
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:news_feed/core/error/exceptions.dart';
import 'package:news_feed/features/news/data/models/article_model.dart';

abstract class NewsLocalDataSource {
  Future<void> cacheBookmark(ArticleModel article);
  Future<void> removeBookmark(String articleId);
  Future<List<ArticleModel>> getBookmarks();
  Future<void> markAsRead(String articleId);
  Future<bool> isArticleRead(String articleId);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final GetStorage _storage;

  static const String _bookmarksKey = 'bookmarked_articles';
  static const String _readArticlesKey = 'read_articles_ids';

  NewsLocalDataSourceImpl(this._storage);

  @override
  Future<List<ArticleModel>> getBookmarks() async {
    try {
      final rawData = _storage.read<String>(_bookmarksKey);
      if (rawData == null) return [];

      final List<dynamic> decodedList = jsonDecode(rawData);
      return decodedList
          .map((item) => ArticleModel.fromJson(item, item['category'] ?? ''))
          .toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheBookmark(ArticleModel article) async {
    try {
      final bookmarks = await getBookmarks();
      if (!bookmarks.any((item) => item.id == article.id)) {
        bookmarks.add(article);
        await _storage.write(
          _bookmarksKey,
          jsonEncode(bookmarks.map((e) => e.toJson()).toList()),
        );
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> removeBookmark(String articleId) async {
    try {
      final bookmarks = await getBookmarks();
      bookmarks.removeWhere((item) => item.id == articleId);
      await _storage.write(
        _bookmarksKey,
        jsonEncode(bookmarks.map((e) => e.toJson()).toList()),
      );
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> markAsRead(String articleId) async {
    try {
      List<dynamic> readIds =
          _storage.read<List<dynamic>>(_readArticlesKey) ?? [];
      if (!readIds.contains(articleId)) {
        readIds.add(articleId);
        await _storage.write(_readArticlesKey, readIds);
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> isArticleRead(String articleId) async {
    try {
      final List<dynamic> readIds =
          _storage.read<List<dynamic>>(_readArticlesKey) ?? [];
      return readIds.contains(articleId);
    } catch (e) {
      throw CacheException();
    }
  }
}
