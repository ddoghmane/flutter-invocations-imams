import 'package:flutter/material.dart';
import 'pages/imams_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Invocations des imams',

      // ⭐ TON THÈME MYSTIQUE DOIT ÊTRE ICI ⭐
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F1A14), // vert sombre
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B5E20), // vert mystique
          brightness: Brightness.dark,
        ),
        cardColor: const Color(0xFF1E2A22),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Color(0xFFE0C084), // doré
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),

      home: const ImamsPage(),
    );
  }
}
