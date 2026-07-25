// features/article_detail/presentation/widgets/article_shimmer.dart
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_feed/core/constants/app_colors.dart';

class ArticleShimmer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;

  const ArticleShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: context.colors.readState.withValues(alpha: 0.3),
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      ),
    );
  }
}
