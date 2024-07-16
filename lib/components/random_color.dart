import 'dart:math';
import 'package:flutter/material.dart';

Color getRandomColor() {
  final List<Color> colors = [
    Color.fromARGB(255, 196, 241, 253),
    Color.fromARGB(255, 253, 196, 196),
    Color.fromARGB(255, 253, 241, 196),
    Color.fromARGB(255, 196, 253, 196),
    Color.fromARGB(255, 241, 196, 253),
  ];
  final random = Random();
  return colors[random.nextInt(colors.length)];
}
