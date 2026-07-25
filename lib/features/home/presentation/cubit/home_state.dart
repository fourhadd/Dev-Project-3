// features/home/presentation/cubit/home_state.dart
import 'package:equatable/equatable.dart';
import 'package:news_feed/features/news/data/models/article_model.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ArticleModel> articles;
  final String selectedCategory;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.articles = const [],
    this.selectedCategory = 'All',
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<ArticleModel>? articles,
    String? selectedCategory,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, articles, selectedCategory, errorMessage];
}
