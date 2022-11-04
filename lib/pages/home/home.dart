import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quest_peak/config/style_provider.dart';
import 'package:quest_peak/domain/models/quest_fetcher.dart';
import 'package:quest_peak/domain/models/quest_model.dart';
import 'package:quest_peak/providers/quest_provider.dart';
import 'package:quest_peak/pages/home/widgets/quest.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  late PageController _pageController; // will assign later
  final _favourites = <String>{};

  // initialized here, not in PageView, overwise
  // _pageController will rebuild often
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: 0,
      keepPage: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuestPeaker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _pushSaved,
            tooltip: 'Saved Suggestions',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: FutureBuilder<List<Quest>>(
                future: QuestFetcher.quests,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 32.0, top: 8.0),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Innopolis",
                                    style: appTheme.display1()),
                                const TextSpan(text: "\n"),
                                TextSpan(
                                    text: "Secrets",
                                    style: appTheme.display2()),
                              ]),
                            )),
                        Expanded(
                            child: PageView(
                          physics: const ClampingScrollPhysics(),
                          // controller: _pageController, // maybe use only list?
                          children: [
                            for (var i = 0; i < snapshot.data!.length; i++)
                              QuestWidget(
                                  quest: snapshot.data![i],
                                  isSaved: _favourites
                                      .contains(snapshot.data![i].name)),
                          ],
                        ))
                      ],
                    );
                  } else {
                    return const Center(
                        child: SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(),
                    ));
                  }
                })),
      ),
    );
  }

  void _pushSaved() {
    final appTheme = ref.watch(themeProvider);

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _favourites.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair,
                  style: appTheme.heading(),
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
