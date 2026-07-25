// features/webview/presentation/cubit/webview_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'webview_state.dart';

class WebViewCubit extends Cubit<WebViewState> {
  WebViewCubit(String url)
    : super(
        WebViewState(
          controller: WebViewController(),
          status: WebViewLoadStatus.loading,
        ),
      ) {
    _init(url);
  }

  void _init(String url) {
    state.controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            emit(state.copyWith(progress: progress / 100));
          },
          onPageStarted: (_) {
            emit(state.copyWith(status: WebViewLoadStatus.loading));
          },
          onPageFinished: (_) {
            emit(state.copyWith(status: WebViewLoadStatus.success));
          },
          onWebResourceError: (error) {
            emit(
              state.copyWith(
                status: WebViewLoadStatus.error,
                errorMessage: error.description,
              ),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  Future<void> reload() async {
    emit(state.copyWith(status: WebViewLoadStatus.loading, progress: 0));
    await state.controller.reload();
  }
}
