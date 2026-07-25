// features/news/data/models/category_model.dart
import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({required super.id, required super.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id'] ?? '', name: json['webTitle'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'webTitle': name};
  }
}
