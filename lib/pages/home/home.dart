import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quest_peak/config/style_provider.dart';
import 'package:quest_peak/domain/models/quest_fetcher.dart';
import 'package:quest_peak/domain/models/quest_model.dart';
import 'package:quest_peak/domain/models/quest_tracker.dart';
import 'package:quest_peak/pages/home/widgets/quest.dart';
import 'package:quest_peak/pages/home/widgets/quest_details.dart';
import 'package:quest_peak/pages/settings.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.applicationName),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: AppLocalizations.of(context)!.savedSuggestions,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _pushSettings,
            tooltip: AppLocalizations.of(context)!.settings,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FutureBuilder<List<Quest>>(
                future: QuestFetcher.quests,
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left: 32.0, top: 8.0),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Innopolis",
                                  style: appTheme.display1()),
                              const TextSpan(text: "\n"),
                              TextSpan(
                                  text: "Secrets", style: appTheme.display2()),
                            ]),
                          )),
                      Expanded(
                          child: (snapshot.hasData)
                              ? (PageView(
                                  physics: const ClampingScrollPhysics(),
                                  children: [
                                    for (var i = 0;
                                        i < snapshot.data!.length;
                                        i++)
                                      QuestWidget(quest: snapshot.data![i]),
                                  ],
                                ))
                              : (snapshot.hasError)
                                  ? Text(
                                      "Could not connect to internet",
                                      style: appTheme.display2(),
                                    )
                                  : const Center(
                                      child: SizedBox(
                                      width: 32,
                                      height: 32,
                                      child: CircularProgressIndicator(),
                                    )))
                    ],
                  );
                })),
      ),
    );
  }

  void _pushSaved() {
    final appTheme = ref.watch(themeProvider);

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.savedSuggestions),
              ),
              body: FutureBuilder<List<Quest>>(
                  future: QuestTracker.getQuests(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final tiles = snapshot.data!.map(
                        (quest) {
                          return ListTile(
                            title: Text(
                              quest.name,
                              style: appTheme.display2(),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration:
                                      const Duration(milliseconds: 400),
                                  pageBuilder: (context, _, __) {
                                    return QuestDetailsWidget(quest: quest);
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                      final divided = tiles.isNotEmpty
                          ? ListTile.divideTiles(
                              context: context,
                              tiles: tiles,
                            ).toList()
                          : <Widget>[];

                      return ListView(children: divided);
                    } else {
                      return const Center(
                          child: SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(),
                      ));
                    }
                  }));
        },
      ),
    );
  }

  void _pushSettings() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const SettingsPage()));
  }
}
