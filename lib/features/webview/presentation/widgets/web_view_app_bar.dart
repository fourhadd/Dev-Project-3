// features/webview/presentation/widgets/web_view_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed/core/constants/app_colors.dart';
import 'package:news_feed/features/webview/presentation/cubit/webview_cubit.dart';
import 'package:news_feed/features/webview/presentation/cubit/webview_state.dart';

class WebViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WebViewAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 3);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.surface,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close_rounded, color: context.colors.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.refresh_rounded, color: context.colors.textPrimary),
          onPressed: () => context.read<WebViewCubit>().reload(),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(3),
        child: BlocSelector<WebViewCubit, WebViewState, double?>(
          selector: (state) =>
              state.status == WebViewLoadStatus.loading ? state.progress : null,
          builder: (context, progress) {
            if (progress == null) return const SizedBox(height: 3);
            return LinearProgressIndicator(
              value: progress,
              minHeight: 3,
              backgroundColor: Colors.transparent,
              color: context.colors.primary,
            );
          },
        ),
      ),
    );
  }
}
