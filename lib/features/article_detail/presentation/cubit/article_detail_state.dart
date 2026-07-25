// features/article_detail/presentation/cubit/article_detail_state.dart
import 'package:equatable/equatable.dart';

class ArticleDetailState extends Equatable {
  final bool isBookmarked;
  final bool isRead;
  final double fontScale;

  const ArticleDetailState({
    this.isBookmarked = false,
    this.isRead = false,
    this.fontScale = 1.0,
  });

  ArticleDetailState copyWith({
    bool? isBookmarked,
    bool? isRead,
    double? fontScale,
  }) {
    return ArticleDetailState(
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isRead: isRead ?? this.isRead,
      fontScale: fontScale ?? this.fontScale,
    );
  }

  @override
  List<Object?> get props => [isBookmarked, isRead, fontScale];
}
