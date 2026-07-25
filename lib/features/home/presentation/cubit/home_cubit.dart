// features/home/presentation/cubit/home_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed/core/network/api_constants.dart';
import 'package:news_feed/features/news/domain/usecases/get_articles_by_category.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetArticlesByCategory _getArticlesByCategory;

  HomeCubit({required GetArticlesByCategory getArticlesByCategory})
    : _getArticlesByCategory = getArticlesByCategory,
      super(const HomeState()) {
    fetchNews();
  }

  Future<void> fetchNews() async {
    emit(
      state.copyWith(
        status: HomeStatus.loading,
        articles: [],
        currentPage: 1,
        hasReachedMax: false,
        isLoadingMore: false,
      ),
    );

    final result = await _getArticlesByCategory(
      GetArticlesByCategoryParams(category: state.selectedCategory, page: 1),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (articles) => emit(
        state.copyWith(
          status: HomeStatus.success,
          articles: articles.cast(),
          currentPage: 1,
          hasReachedMax: articles.length < ApiConstants.pageSize,
        ),
      ),
    );
  }

  Future<void> fetchMoreNews() async {
    if (state.isLoadingMore || state.hasReachedMax) return;
    if (state.status != HomeStatus.success) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;
    final result = await _getArticlesByCategory(
      GetArticlesByCategoryParams(
        category: state.selectedCategory,
        page: nextPage,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(isLoadingMore: false)),
      (articles) => emit(
        state.copyWith(
          status: HomeStatus.success,
          articles: [...state.articles, ...articles.cast()],
          currentPage: nextPage,
          hasReachedMax: articles.length < ApiConstants.pageSize,
          isLoadingMore: false,
        ),
      ),
    );
  }

  void changeCategory(String category) {
    if (state.selectedCategory == category) return;
    emit(state.copyWith(selectedCategory: category));
    fetchNews();
  }
}
