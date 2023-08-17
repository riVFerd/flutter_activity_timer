import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/logic/bloc/activities_bloc.dart';
import 'package:flutter_activity_timer/presentation/router/app_router.dart';
import 'package:flutter_activity_timer/presentation/theme/theme_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivitiesBloc(),
      child: MaterialApp(
        title: 'Activity Timer',
        theme: ThemeConstants.defaultTheme,
        onGenerateRoute: AppRouter().onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
