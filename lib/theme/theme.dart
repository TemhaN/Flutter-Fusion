import 'package:flutter/material.dart';

final FusionTheme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(255, 41, 41, 41),
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromRGBO(69, 70, 85, 1)),
  useMaterial3: true,
  dividerColor: Colors.white24,
  listTileTheme: const ListTileThemeData(iconColor: Colors.white),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 10,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700)),
      textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      labelSmall: TextStyle(
        color: Colors.white24,
        fontWeight: FontWeight.w300,
        fontSize: 14,
      ),
      labelLarge: TextStyle(
        fontSize: 20,
      )),
);
