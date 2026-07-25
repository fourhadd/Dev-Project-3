// features/article_detail/presentation/widgets/article_body_content.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_feed/core/constants/app_colors.dart';
import 'package:news_feed/core/constants/app_text_styles.dart';
import '../cubit/article_detail_cubit.dart';
import '../cubit/article_detail_state.dart';

class ArticleBodyContent extends StatelessWidget {
  final String content;

  const ArticleBodyContent({super.key, required this.content});

  String _formatParagraphs(String rawText) {
    if (rawText.isEmpty) return '';
    final timeRegex = RegExp(r'(\d{1,2}\.\d{2}(?:am|pm)\s+[A-Z]{3})');
    String formatted = rawText.replaceAllMapped(timeRegex, (match) {
      final foundTime = match.group(0);
      return '\n\n$foundTime';
    });

    return formatted.trim();
  }

  @override
  Widget build(BuildContext context) {
    final formattedContent = _formatParagraphs(content);

    return BlocBuilder<ArticleDetailCubit, ArticleDetailState>(
      buildWhen: (prev, curr) => prev.fontScale != curr.fontScale,
      builder: (context, state) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(state.fontScale)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              formattedContent,
              style: AppTextStyles.bodyLarge.copyWith(
                color: context.colors.textPrimary,
                height: 1.6,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        );
      },
    );
  }
}
