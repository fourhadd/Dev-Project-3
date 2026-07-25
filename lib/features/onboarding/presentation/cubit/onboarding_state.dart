// features/onboarding/presentation/cubit/onboarding_state.dart
import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final List<String> availableCategories;
  final List<String> selectedCategories;
  final bool isSaved;

  const OnboardingState({
    required this.availableCategories,
    required this.selectedCategories,
    this.isSaved = false,
  });

  OnboardingState copyWith({
    List<String>? availableCategories,
    List<String>? selectedCategories,
    bool? isSaved,
  }) {
    return OnboardingState(
      availableCategories: availableCategories ?? this.availableCategories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [availableCategories, selectedCategories, isSaved];
}
