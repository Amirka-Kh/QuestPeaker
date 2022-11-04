import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quest_peak/config/style_provider.dart';
import 'package:quest_peak/domain/models/quest_model.dart';

class QuestDetailsWidget extends ConsumerStatefulWidget {
  final Quest quest;

  const QuestDetailsWidget({super.key, required this.quest});

  @override
  ConsumerState<QuestDetailsWidget> createState() => _QuestDetailsWidgetState();
}

class _QuestDetailsWidgetState extends ConsumerState<QuestDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final appTheme = ref.watch(themeProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // will use available space
        children: <Widget>[
          DecoratedBox(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: toListColor(widget.quest.colors),
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          )),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16),
                  child: IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.close),
                    color: Colors.white.withOpacity(0.9),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(widget.quest.imagePath,
                      height: screenHeight * 0.45),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                  child: Material(
                      color: Colors.transparent,
                      child:
                          Text(widget.quest.name, style: appTheme.heading())),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 8, 120),
                  child: Text(widget.quest.description,
                      style: appTheme.subHeading()),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
