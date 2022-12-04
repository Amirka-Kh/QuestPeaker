import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quest_peak/config/settings_provider.dart';
import 'package:quest_peak/domain/models/quest_fetcher.dart';
import 'package:quest_peak/domain/models/quest_tracker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quest_peak/domain/models/settings_model.dart';
import './pages/home/home.dart';
import './domain/models/quest_model.dart';
import 'domain/models/custom_error.dart';

void main() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(QuestColorAdapter())
    ..registerAdapter(QuestAdapter())
    ..registerAdapter(SettingsAdapter());
  QuestTracker.fetch();
  QuestFetcher.fetch();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SettingsTracker.fetch(ref);
    final settings = ref.watch(darkModeProvider);

    return MaterialApp(
      title: 'Startup Name Generator',
      theme: settings == false
          ? ThemeData(
              appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ))
          : ThemeData(
              appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            )),
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomError(errorDetails: errorDetails);
        };
        return widget!;
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('en', ''), Locale('ru', '')],
      home: const HomePage(),
    );
  }
}
