import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.black,
    secondary: const Color.fromARGB(137, 37, 36, 36),
  ),
);
