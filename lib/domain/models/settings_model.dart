import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quest_peak/config/settings_provider.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 2)
class Settings {
  @HiveField(0)
  final bool darkMode;

  Settings(this.darkMode);
}

class SettingsTracker {
  static late Settings settings;

  static void fetch(WidgetRef ref) async {
    var box = await Hive.openBox<Settings>('settings');
    settings = box.get('settings', defaultValue: Settings(false))!;
    ref.watch(darkModeProvider.notifier).set(settings.darkMode);
  }

  static void store(WidgetRef ref) async {
    settings = Settings(ref.watch(darkModeProvider));
    var box = await Hive.openBox<Settings>('settings');
    box.put('settings', settings);
  }
}
