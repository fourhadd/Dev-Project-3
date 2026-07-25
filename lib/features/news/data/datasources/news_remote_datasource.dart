// features/news/data/datasources/news_remote_datasource.dart
import 'package:dio/dio.dart';
import 'package:news_feed/core/network/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getArticlesByCategory(String category);
  Future<List<ArticleModel>> searchArticles(String query);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio _dio;

  NewsRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ArticleModel>> getArticlesByCategory(String category) async {
    try {
      final Map<String, dynamic> queryParams = {
        'show-fields': 'headline,body,thumbnail,byline',
        'api-key': ApiConstants.apiKey,
      };

      if (category.toLowerCase() != 'all') {
        queryParams['section'] = category.toLowerCase();
      }

      final response = await _dio.get(
        '${ApiConstants.baseUrl}/search',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List results = response.data['response']['results'] ?? [];
        return results
            .map((json) => ArticleModel.fromJson(json, category))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<ArticleModel>> searchArticles(String query) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/search',
        queryParameters: {
          'q': query,
          'show-fields': 'headline,body,thumbnail,byline',
          'api-key': ApiConstants.apiKey,
        },
      );

      if (response.statusCode == 200) {
        final List results = response.data['response']['results'] ?? [];
        return results
            .map(
              (json) =>
                  ArticleModel.fromJson(json, json['sectionId'] ?? 'General'),
            )
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
