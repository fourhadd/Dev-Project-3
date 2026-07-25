// features/news/domain/entities/article_entity.dart
import 'package:equatable/equatable.dart';
import 'package:news_feed/features/news/domain/entities/source_entity.dart';

class ArticleEntity extends Equatable {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;
  final SourceEntity source;
  final String? author;
  final DateTime publishedAt;
  final String category;
  final String url;

  const ArticleEntity({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.source,
    this.author,
    required this.publishedAt,
    required this.category,
    required this.url,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    imageUrl,
    source,
    author,
    publishedAt,
    category,
    url,
  ];
}
