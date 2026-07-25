// features/home/presentation/cubit/home_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
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
    emit(state.copyWith(status: HomeStatus.loading, articles: []));

    final result = await _getArticlesByCategory(state.selectedCategory);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (articles) => emit(
        state.copyWith(status: HomeStatus.success, articles: articles.cast()),
      ),
    );
  }

  void changeCategory(String category) {
    if (state.selectedCategory == category) return;
    emit(state.copyWith(selectedCategory: category));
    fetchNews();
  }
}
