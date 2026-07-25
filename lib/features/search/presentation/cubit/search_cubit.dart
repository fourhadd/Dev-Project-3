// features/search/presentation/cubit/search_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_feed/features/news/data/models/article_model.dart';
import 'package:news_feed/features/news/domain/usecases/search_articles.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchArticles _searchArticles;
  Timer? _debounceTimer;

  final GetStorage _storage = GetStorage();
  final String _storageKey = 'recent_searches_key';

  List<String> _recentSearches = [];
  List<ArticleModel> _recommendedArticles = [];

  String _currentSearchQuery = '';

  SearchCubit({required SearchArticles searchArticles})
    : _searchArticles = searchArticles,
      super(SearchInitial()) {
    _loadRecentSearchesFromStorage();
  }

  List<String> get recentSearches => _recentSearches;
  List<ArticleModel> get recommendedArticles => _recommendedArticles;
  String get currentSearchQuery => _currentSearchQuery;

  void _loadRecentSearchesFromStorage() {
    final List<dynamic>? storedList = _storage.read<List<dynamic>>(_storageKey);
    if (storedList != null) {
      _recentSearches = storedList.cast<String>();
    }
  }

  Future<void> loadRecommendations() async {
    if (_recommendedArticles.isNotEmpty) return;
    final result = await _searchArticles('trend');
    result.fold((failure) => null, (articles) {
      _recommendedArticles = articles.cast<ArticleModel>();
      emit(SearchInitial());
    });
  }

  void onSearchTextChanged(String query) {
    _currentSearchQuery = query;
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      emit(SearchInitial());
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _executeSearch(trimmedQuery);
    });
  }

  void onRecentSearchClicked(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _currentSearchQuery = query;
    _executeSearch(query.trim());
  }

  Future<void> _executeSearch(String query) async {
    emit(SearchLoading());
    final result = await _searchArticles(query);

    result.fold(
      (failure) => emit(const SearchError('Axtarış zamanı xəta baş verdi.')),
      (articles) {
        _recentSearches.remove(query);
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 3) {
          _recentSearches = _recentSearches.sublist(0, 3);
        }
        _storage.write(_storageKey, _recentSearches);
        emit(SearchSuccess(articles.cast<ArticleModel>()));
      },
    );
  }

  void clearSearch() {
    _currentSearchQuery = '';
    emit(SearchInitial());
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
