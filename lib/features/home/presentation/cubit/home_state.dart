// features/home/presentation/cubit/home_state.dart
import 'package:equatable/equatable.dart';
import 'package:news_feed/features/news/data/models/article_model.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ArticleModel> articles;
  final String selectedCategory;
  final String? errorMessage;
  final int currentPage;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const HomeState({
    this.status = HomeStatus.initial,
    this.articles = const [],
    this.selectedCategory = 'All',
    this.errorMessage,
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<ArticleModel>? articles,
    String? selectedCategory,
    String? errorMessage,
    int? currentPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return HomeState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    status,
    articles,
    selectedCategory,
    errorMessage,
    currentPage,
    hasReachedMax,
    isLoadingMore,
  ];
}
