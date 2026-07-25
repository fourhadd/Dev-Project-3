// features/article_detail/presentation/widgets/article_bottom_actions.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:news_feed/core/constants/app_colors.dart';
import 'package:news_feed/core/constants/app_strings.dart';
import 'package:news_feed/core/constants/app_text_styles.dart';

class ArticleBottomActions extends StatelessWidget {
  final String url;

  const ArticleBottomActions({super.key, required this.url});

  Future<void> _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    await SharePlus.instance.share(
      ShareParams(
        text: url,
        subject: 'Xəbəri Paylaş',
        sharePositionOrigin: box != null
            ? box.localToGlobal(Offset.zero) & box.size
            : null,
      ),
    );
  }

  void _onOpenOriginal(BuildContext context) {
    context.push('/webview', extra: url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(
          top: BorderSide(
            color: context.colors.divider ?? Colors.transparent,
            width: 1.h,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 48.h,
              child: OutlinedButton.icon(
                onPressed: () => _onOpenOriginal(context),
                icon: Icon(
                  Icons.open_in_new_rounded,
                  size: 18.r,
                  color: context.colors.primary,
                ),
                label: Text(
                  AppStrings.originalSource,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: context.colors.primary, width: 1.5.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            height: 48.h,
            width: 48.w,
            decoration: BoxDecoration(
              color: context.colors.readState.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: Icon(
                Icons.share_outlined,
                color: context.colors.textPrimary,
                size: 20.r,
              ),
              onPressed: () => _onShare(context),
            ),
          ),
        ],
      ),
    );
  }
}
