import 'package:flutter/material.dart';
import 'package:quest_peak/domain/models/quest_model.dart';

List questList = <Quest>[
  Quest(
    'Robotics Lab',
    'assets/quest/robot.png',
    'bla-bla',
    [Colors.lightGreen.shade200, Colors.green.shade800],
  ),
  Quest(
    'Machine Rise',
    'assets/quest/calculator.png',
    'bla-bla',
    [
      const Color.fromARGB(255, 131, 24, 24),
      const Color.fromARGB(255, 255, 6, 56)
    ],
  ),
];
