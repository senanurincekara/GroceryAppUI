import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.grey,
    secondary: const Color.fromARGB(255, 211, 193, 193),
  ),
);
