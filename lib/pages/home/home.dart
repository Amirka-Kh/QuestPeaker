import 'package:flutter/material.dart';
import 'package:quest_peak/providers/quest_provider.dart';
import 'package:quest_peak/pages/home/widgets/quest.dart';
import 'package:quest_peak/config/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 32.0, top: 8.0),
                  child: RichText(
                    text: const TextSpan(children: [
                      TextSpan(text: "Innopolis", style: AppTheme.display1),
                      TextSpan(text: "\n"),
                      TextSpan(text: "Secrets", style: AppTheme.display2),
                    ]),
                  )),
              Expanded(
                  child: PageView(
                physics: const ClampingScrollPhysics(),
                // controller: _pageController, // maybe use only list?
                children: [
                  for (var i = 0; i < questList.length; i++)
                    QuestWidget(
                        quest: questList[i],
                        isSaved: _favourites.contains(questList[i].name)),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _favourites.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair,
                  style: AppTheme.heading,
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
