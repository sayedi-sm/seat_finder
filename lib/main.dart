import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/models.dart';
import 'providers/providers.dart';
import 'screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SeatFinderProvider(),
      child: Consumer<SeatFinderProvider>(
          builder: (_, SeatFinderProvider provider, __) {
        return MaterialApp(
          title: Strings.appTitle,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF2177CF),
              brightness:
                  provider.isLightMode ? Brightness.light : Brightness.dark,
            ),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const SeatFinderScreen(),
        );
      }),
    );
  }
}
