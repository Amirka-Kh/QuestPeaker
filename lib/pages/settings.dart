import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quest_peak/config/settings_provider.dart';
import 'package:quest_peak/domain/models/settings_model.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends ConsumerState<SettingsPage> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    darkMode = ref.watch(darkModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(children: [
            Text(AppLocalizations.of(context)!.darkMode),
            Switch(
                value: darkMode,
                onChanged: (value) {
                  setState(() {
                    final settings = ref.watch(darkModeProvider.notifier);
                    darkMode = value;
                    settings.set(value);
                    SettingsTracker.store(ref);
                  });
                }),
          ]),
        ),
      ),
    );
  }
}
