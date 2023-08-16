import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/presentation/router/app_router.dart';
import 'package:flutter_activity_timer/presentation/theme/theme_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Timer',
      theme: ThemeConstants.defaultTheme,
      onGenerateRoute: AppRouter().onGenerateRoute,
    );
  }
}
