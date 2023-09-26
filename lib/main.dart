import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/firebase_options.dart';
import 'package:flutter_activity_timer/logic/bloc/activities_bloc.dart';
import 'package:flutter_activity_timer/logic/bloc/activity_timer_bloc.dart';
import 'package:flutter_activity_timer/presentation/router/app_router.dart';
import 'package:flutter_activity_timer/presentation/theme/theme_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => ActivitiesBloc()), BlocProvider(create: (context) => ActivityTimerBloc())],
      child: MaterialApp(
        title: 'Activity Timer',
        theme: ThemeConstants.defaultTheme,
        onGenerateRoute: AppRouter().onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
