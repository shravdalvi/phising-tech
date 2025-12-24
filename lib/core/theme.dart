import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,

  // ⭐ LIGHT COLOR SCHEME
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.light,
  ),

  // ⭐ THIS FIXES THE BLACK / DARK ISSUE EVERYWHERE
  scaffoldBackgroundColor: const Color(0xFFF6F2FF),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF6F2FF),
    elevation: 0,
    centerTitle: true,
    foregroundColor: Colors.black,
  ),
);
