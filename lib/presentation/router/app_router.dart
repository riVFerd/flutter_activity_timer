import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/logic/models/activity.dart';
import 'package:flutter_activity_timer/presentation/screens/activity_screen.dart';
import 'package:flutter_activity_timer/presentation/screens/home_screen.dart';

final class AppRouter {
  MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case ActivityScreen.routeName:
        final activity = settings.arguments as Activity;
        return MaterialPageRoute(
          builder: (_) => ActivityScreen(activity: activity),
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
