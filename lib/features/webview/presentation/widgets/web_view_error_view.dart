// features/webview/presentation/widgets/web_view_error_view.dart
import 'package:flutter/material.dart';
import 'package:news_feed/core/constants/app_colors.dart';
import 'package:news_feed/core/constants/app_text_styles.dart';

class WebViewErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback onRetry;

  const WebViewErrorView({super.key, this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 48,
              color: context.colors.textSecondary,
            ),
            const SizedBox(height: 12),
            Text(
              'Səhifə yüklənmədi',
              style: AppTextStyles.headlineMedium.copyWith(
                color: context.colors.textPrimary,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 4),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: context.colors.textSecondary,
                ),
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
              ),
              child: const Text('Yenidən cəhd et'),
            ),
          ],
        ),
      ),
    );
  }
}
