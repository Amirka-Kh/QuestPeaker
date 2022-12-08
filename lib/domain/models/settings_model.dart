import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quest_peak/config/settings_provider.dart';
import 'package:quest_peak/config/style_provider.dart';
import 'package:quest_peak/config/styles.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 2)
class Settings {
  @HiveField(0)
  final bool darkMode;
  @HiveField(1)
  final FilterType filter;

  Settings(this.darkMode, this.filter);
}

@HiveType(typeId: 3)
enum FilterType {
  @HiveField(0)
  all,
  @HiveField(1)
  solved,
  @HiveField(2)
  notSolved
}

int filterToInt(FilterType x) {
  switch (x) {
    case FilterType.all:
      return 0;
    case FilterType.solved:
      return 1;
    case FilterType.notSolved:
      return 2;
  }
}

FilterType intToFilter(int x) {
  switch (x) {
    case 0:
      return FilterType.all;
    case 1:
      return FilterType.solved;
    case 2:
      return FilterType.notSolved;
  }
  return FilterType.all;
}

class SettingsTracker {
  static const boxName = 'settingsData';
  static late Settings settings;

  static void fetch(WidgetRef ref) async {
    var box = await Hive.openBox<Settings>(boxName);
    settings =
        box.get('settings', defaultValue: Settings(false, FilterType.all))!;
    ref.watch(darkModeProvider.notifier).set(settings.darkMode);
    ref.watch(filterProvider.notifier).set(settings.filter);
    if (!settings.darkMode) {
      ref.watch(themeProvider.notifier).set(AppThemeDefault());
    } else {
      ref.watch(themeProvider.notifier).set(AppThemeDark());
    }
  }

  static void store(WidgetRef ref) async {
    bool darkMode = ref.watch(darkModeProvider);
    FilterType filter = ref.watch(filterProvider);
    settings = Settings(darkMode, filter);
    var box = await Hive.openBox<Settings>(boxName);
    box.put('settings', settings);
  }

  static void delete(WidgetRef ref) async {
    var box = await Hive.openBox<Settings>(boxName);
    box.clear();
    settings = Settings(false, FilterType.all);
  }
}
