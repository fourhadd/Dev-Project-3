// features/onboarding/presentation/cubit/onboarding_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final GetStorage _storage;
  final HomeCubit _homeCubit;

  static const String _categoriesKey = 'user_selected_categories';
  static const String _onboardingCompleteKey = 'is_onboarding_complete';

  static const List<String> _guardianSections = [
    'Technology',
    'Sport',
    'Business',
    'Politics',
    'World',
    'Environment',
    'Science',
    'Fashion',
  ];

  OnboardingCubit(this._storage, this._homeCubit)
    : super(
        const OnboardingState(
          availableCategories: _guardianSections,
          selectedCategories: [],
        ),
      ) {
    _loadSavedCategories();
  }

  void _loadSavedCategories() {
    final List<dynamic>? saved = _storage.read<List<dynamic>>(_categoriesKey);
    if (saved != null) {
      emit(state.copyWith(selectedCategories: List<String>.from(saved)));
    }
  }

  void toggleCategory(String category) {
    final updatedList = List<String>.from(state.selectedCategories);
    if (updatedList.contains(category)) {
      updatedList.remove(category);
    } else {
      updatedList.add(category);
    }

    emit(state.copyWith(selectedCategories: updatedList, isSaved: false));
  }

  Future<void> savePreferences() async {
    if (state.selectedCategories.isNotEmpty) {
      emit(state.copyWith(isSaved: false));

      await _storage.write(_categoriesKey, state.selectedCategories);
      await _storage.write(_onboardingCompleteKey, true);

      _homeCubit.fetchNews();

      emit(state.copyWith(isSaved: true));
    }
  }

  bool isOnboardingComplete() {
    return _storage.read<bool>(_onboardingCompleteKey) ?? false;
  }
}
