import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/logic/models/activity.dart';
import 'package:flutter_activity_timer/presentation/theme/theme_constants.dart';
import 'package:flutter_activity_timer/presentation/widgets/activity_card.dart';
import 'package:flutter_activity_timer/presentation/widgets/auth_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/activities_bloc.dart';
import '../../logic/bloc/activity_timer_bloc.dart';
import '../widgets/input_activity_modal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ActivitiesBloc>(context).add(ActivitiesLoad());

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            width: double.infinity,
            color: ThemeConstants.light,
            height: MediaQuery.of(context).size.height * 0.95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Today Activities',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const AuthModal(),
                      ),
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: ThemeConstants.darkBlue,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: ThemeConstants.darkBlue,
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 42,
                            vertical: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Activity',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.percent,
                                color: Colors.white,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              BlocBuilder<ActivityTimerBloc, ActivityTimerState>(
                                builder: (context, state) {
                                  if (state is ActivityTimerRunning) {
                                    return ActivityCard(activity: state.activity!);
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              Expanded(
                                child: BlocBuilder<ActivitiesBloc, ActivitiesState>(
                                  builder: (context, state) {
                                    if (state is ActivitiesLoaded) {
                                      final activities = state.activities;
                                      bool isTimerRunning = false;

                                      if (context.read<ActivityTimerBloc>().state is ActivityTimerRunning) {
                                        isTimerRunning = true;
                                        final runningActivity = context.read<ActivityTimerBloc>().state.activity;
                                        activities.removeWhere((activity) => activity.activityId == runningActivity!.activityId);
                                      }

                                      if (activities.isEmpty) {
                                        return const Center(
                                          child: Text(
                                            'No activities yet!',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        );
                                      }

                                      return displayActivityCards(activities, isTimerRunning);
                                    } else if (state is ActivitiesLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (state is ActivitiesError) {
                                      return Center(
                                        child: Text(state.message),
                                      );
                                    } else {
                                      return const Center(
                                        child: Text('Something went wrong!'),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: ThemeConstants.darkBlue,
              builder: (context) {
                return const InputActivityModal();
              },
            );
          },
          backgroundColor: ThemeConstants.lightBrown,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            size: 32,
          ),
        ),
        floatingActionButtonLocation: const _CustomFabLoc(),
      ),
    );
  }

  ListView displayActivityCards(List<Activity> activities, bool isTimerRunning) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return AbsorbPointer(
          absorbing: (isTimerRunning),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
            child: Opacity(
              opacity: (isTimerRunning) ? 0.5 : 1.0,
              child: ActivityCard(
                activity: activities[index],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CustomFabLoc extends FloatingActionButtonLocation {
  const _CustomFabLoc();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
      scaffoldGeometry.scaffoldSize.width - 84.0,
      scaffoldGeometry.scaffoldSize.height - 84.0,
    );
  }
}
