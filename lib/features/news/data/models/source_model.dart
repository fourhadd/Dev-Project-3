// features/news/data/models/source_model.dart
import 'package:news_feed/features/news/domain/entities/source_entity.dart';

class SourceModel extends SourceEntity {
  const SourceModel({required super.id, required super.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'] ?? 'the-guardian',
      name: json['name'] ?? 'The Guardian',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }

  factory SourceModel.fromEntity(SourceEntity entity) {
    return SourceModel(id: entity.id, name: entity.name);
  }
}
