import 'package:flutter/material.dart';
import 'package:quest_peak/domain/models/quest_tracker.dart';

import '../../../domain/models/quest_model.dart';

class SaveToFavouritesWidget extends StatefulWidget {
  final Quest quest;
  const SaveToFavouritesWidget({super.key, required this.quest});

  @override
  State<SaveToFavouritesWidget> createState() => _SaveToFavouritesWidgetState();
}

class _SaveToFavouritesWidgetState extends State<SaveToFavouritesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: QuestTracker.containQuest(widget.quest),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool isSaved = snapshot.data!;
            return GestureDetector(
                child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(180, 255, 255, 255),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isSaved ? Icons.favorite : Icons.favorite_border,
                      color: isSaved ? Colors.red : null,
                      semanticLabel: isSaved ? 'Remove from saved' : 'Save',
                    )),
                onTap: () {
                  setState(() {
                    if (!isSaved) {
                      QuestTracker.addQuest(widget.quest);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Quest have been saved to favorites')));
                    } else {
                      QuestTracker.deleteQuest(widget.quest);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('Quest have been removed from favorites')));
                    }
                  });
                });
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
