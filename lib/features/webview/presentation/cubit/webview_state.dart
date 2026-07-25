// features/webview/presentation/cubit/webview_state.dart
import 'package:equatable/equatable.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum WebViewLoadStatus { loading, success, error }

class WebViewState extends Equatable {
  final WebViewController controller;
  final WebViewLoadStatus status;
  final double progress;
  final String? errorMessage;

  const WebViewState({
    required this.controller,
    required this.status,
    this.progress = 0,
    this.errorMessage,
  });

  WebViewState copyWith({
    WebViewLoadStatus? status,
    double? progress,
    String? errorMessage,
  }) {
    return WebViewState(
      controller: controller,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, progress, errorMessage];
}
