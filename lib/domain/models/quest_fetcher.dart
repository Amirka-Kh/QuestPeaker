import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:quest_peak/domain/models/quest_model.dart';

class QuestFetcher {
  static late Future<List<Quest>> quests;

  static void fetch() async {
    quests = _fetchQuests();
  }

  static Future<List<Quest>> _fetchQuests() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Amirka-Kh/QuestPeaker/main/api/quests.json'));
    if (response.statusCode == 200) {
      List<Quest> quests = [];
      final List<Map<String, dynamic>> list =
          json.decode(response.body).cast<Map<String, dynamic>>();
      for (int i = 0; i < list.length; i++) {
        quests.add(Quest(
            list[i]['name'],
            list[i]['description'],
            list[i]['question'],
            list[i]['answer'],
            list[i]['latitude'],
            list[i]['longitude'],
            list[i]['imagePath'],
            toListQuestColor(list[i]['colors'].cast<String>())));
      }
      return quests;
    } else {
      throw Exception("Could not retrieve data");
    }
  }
}
