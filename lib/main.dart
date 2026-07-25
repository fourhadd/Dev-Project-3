// main.dart
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_feed/app/app.dart';
import 'core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await di.init();

  runApp(const NewFeedsApp());
}
