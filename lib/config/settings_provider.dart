import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quest_peak/domain/models/settings_model.dart';

// final settingsProvider = StateNotifierProvider<SettingsClass, SettingsType>(
//     (ref) => SettingsClass());

final darkModeProvider =
    StateNotifierProvider<SettingsClass, bool>((ref) => SettingsClass(false));

class SettingsClass extends StateNotifier<bool> {
  SettingsClass(super.state);

  void set(bool s) {
    state = s;
  }
}

/* class SettingsType {
  SettingsType({required darkMode});
  bool darkMode = false;
} */

/* class SettingsClass extends StateNotifier<SettingsType> {
  SettingsClass() : super(SettingsType(darkMode: false));

  void setDarkMode(bool value) {
    state.darkMode = value;
  }

  bool getDarkMode() {
    return state.darkMode;
  }

  void setSettings(SettingsType settings) {
    state = settings;
  }
} */
