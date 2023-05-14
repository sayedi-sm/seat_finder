import 'package:flutter/material.dart';
import 'package:seat_finder/seat_finder_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seat Finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2177CF)),
        useMaterial3: true,
      ),
      home: const SeatFinderScreen(),
    );
  }
}
