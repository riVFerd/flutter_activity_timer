import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/presentation/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Timer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF87CEFA)),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter().onGenerateRoute,
    );
  }
}