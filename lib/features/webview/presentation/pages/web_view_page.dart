// features/webview/presentation/pages/web_view_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed/features/webview/presentation/cubit/webview_cubit.dart';
import 'package:news_feed/features/webview/presentation/widgets/web_view_app_bar.dart';
import 'package:news_feed/features/webview/presentation/widgets/web_view_body.dart';

class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WebViewCubit(url),
      child: Scaffold(appBar: const WebViewAppBar(), body: const WebViewBody()),
    );
  }
}
