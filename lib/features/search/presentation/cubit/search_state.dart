// features/search/presentation/cubit/search_state.dart
import 'package:equatable/equatable.dart';
import 'package:news_feed/features/news/domain/entities/article_entity.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<ArticleEntity> articles;

  const SearchSuccess(this.articles);

  @override
  List<Object?> get props => [articles];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
