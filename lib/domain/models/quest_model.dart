import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'quest_model.g.dart';

@HiveType(typeId: 0)
class Quest {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String imagePath;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<QuestColor> colors;
  // final List<Color> colors; // Does Hive have provider for Color?

  Quest(this.name, this.imagePath, this.description, this.colors);
}

@HiveType(typeId: 1)
enum QuestColor {
  @HiveField(0)
  lightGreen,
  @HiveField(1)
  green,
  @HiveField(2)
  darkRed,
  @HiveField(3)
  red,
}

Color getColor(QuestColor color) {
  switch (color) {
    case QuestColor.lightGreen:
      return Colors.lightGreen.shade200;
    case QuestColor.green:
      return Colors.green.shade800;
    case QuestColor.darkRed:
      return const Color.fromARGB(255, 131, 24, 24);
    case QuestColor.red:
      return const Color.fromARGB(255, 255, 6, 56);
  }
}

List<Color> toListColor(List<QuestColor> list) {
  List<Color> list2 = [];
  for (int i = 0; i < list.length; i++) {
    list2.add(getColor(list[i]));
  }
  return list2;
}
