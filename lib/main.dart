import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quest_peak/domain/models/quest_tracker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './config/styles.dart';
import './pages/home/home.dart';
import './domain/models/quest_model.dart';
import 'domain/models/custom_error.dart';

void main() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(QuestColorAdapter())
    ..registerAdapter(QuestAdapter());
  QuestTracker.fetch();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        // Add the 5 lines from here...
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomError(errorDetails: errorDetails);
        };
        return widget!;
      },
      home: const HomePage(),
    );
  }
}
