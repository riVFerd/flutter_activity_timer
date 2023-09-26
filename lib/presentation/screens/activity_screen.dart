import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/logic/bloc/activities_bloc.dart';
import 'package:flutter_activity_timer/presentation/theme/card_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/activity_timer_bloc.dart';
import '../../logic/models/activity.dart';
import '../theme/theme_constants.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key, required this.activity});

  final Activity activity;
  static const routeName = '/activity';

  void _startTimer(BuildContext context, Activity activity) {
    BlocProvider.of<ActivityTimerBloc>(context).add(ActivityTimerStarted(activity: activity));
    BlocProvider.of<ActivitiesBloc>(context).add(ActivitiesLoad());
  }

  void _stopTimer(BuildContext context, Activity activity) {
    BlocProvider.of<ActivityTimerBloc>(context).add(ActivityTimerStopped(activity: activity));
    BlocProvider.of<ActivitiesBloc>(context).add(ActivitiesLoad());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (BlocProvider.of<ActivityTimerBloc>(context).state is ActivityTimerPaused) {
          BlocProvider.of<ActivityTimerBloc>(context).add(ActivityTimerReset());
        }
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(12.0),
            width: double.infinity,
            color: ThemeConstants.light,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.activityName,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: CardConstants.backgroundColors[activity.colorId],
                    ),
                    child: BlocBuilder<ActivityTimerBloc, ActivityTimerState>(
                      builder: (context, state) {
                        Activity updatedActivity = activity.copyWith(
                          timeSpent: (state.activity != null) ? state.activity!.timeSpent : activity.timeSpent,
                        );
                        return Column(
                          children: [
                            Flexible(
                              flex: 3,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Transform.scale(
                                      scale: 8,
                                      child: Hero(
                                        tag: activity.activityId,
                                        child: CircularProgressIndicator(
                                          value: updatedActivity.ratioPercentage,
                                          valueColor: const AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                          strokeWidth: 4,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '${updatedActivity.hours}:${updatedActivity.minutes}:${updatedActivity.seconds}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Flexible(
                              child: IconButton(
                                onPressed: () {
                                  if (state is ActivityTimerRunning) {
                                    _stopTimer(context, updatedActivity);
                                  } else {
                                    _startTimer(context, updatedActivity);
                                  }
                                },
                                icon: Icon(
                                  state is ActivityTimerRunning ? Icons.pause : Icons.play_arrow,
                                ),
                                color: Colors.white,
                                iconSize: 64,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    ThemeConstants.darkBlue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
