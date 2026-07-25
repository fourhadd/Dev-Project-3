// features/webview/presentation/widgets/web_view_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:news_feed/features/webview/presentation/cubit/webview_cubit.dart';
import 'package:news_feed/features/webview/presentation/cubit/webview_state.dart';
import 'package:news_feed/features/webview/presentation/widgets/web_view_error_view.dart';

class WebViewBody extends StatelessWidget {
  const WebViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebViewCubit, WebViewState>(
      builder: (context, state) {
        if (state.status == WebViewLoadStatus.error) {
          return WebViewErrorView(
            message: state.errorMessage,
            onRetry: () => context.read<WebViewCubit>().reload(),
          );
        }
        return WebViewWidget(controller: state.controller);
      },
    );
  }
}
