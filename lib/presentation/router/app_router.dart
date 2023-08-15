import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/presentation/screens/home_screen.dart';

final class AppRouter {
  MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
