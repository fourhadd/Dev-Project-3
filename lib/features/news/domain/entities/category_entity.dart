// features/news/domain/entities/category_entity.dart
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String name;

  const CategoryEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
