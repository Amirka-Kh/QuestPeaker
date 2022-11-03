import 'package:flutter/material.dart';
import 'package:quest_peak/domain/models/quest_model.dart';
import 'package:quest_peak/pages/home/widgets/quest_details.dart';
import 'package:quest_peak/pages/home/widgets/to_favorite_button.dart';
import 'package:quest_peak/config/styles.dart';

class QuestWidget extends StatelessWidget {
  final Quest quest;
  final bool isSaved;

  const QuestWidget({super.key, required this.quest, required this.isSaved});

  // user will interact with a widget, thus Gesture detection is needed
  // for this purposes InkWell is used since it  shows a visual indication
  // that the touch was received, while in GestureDetector this should be implemented
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, _, __) {
              return QuestDetailsWidget(quest: quest);
            },
          ),
        );
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: QuestCardClipper(),
              child: Container(
                height: 0.5 * screenHeight,
                width: 0.9 * screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: toListColor(quest.colors),
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.5),
            child: Image.asset(
              quest.imagePath,
              height: screenHeight * 0.5,
              width: screenWidth * 0.7,
            ),
          ),
          Align(
            alignment: const Alignment(0.8, 0.95),
            child: SaveToFavouritesWidget(quest: quest),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: Container(
                    child: Text(
                      quest.name,
                      style: AppTheme.heading,
                    ),
                  ),
                ),
                const Text(
                  "Learn more",
                  style: AppTheme.subHeading,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
