import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/logic/models/activity.dart';
import 'package:flutter_activity_timer/presentation/theme/theme_constants.dart';
import 'package:flutter_activity_timer/presentation/widgets/activity_card.dart';

import '../widgets/input_activity_modal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(12.0),
          width: double.infinity,
          color: ThemeConstants.light,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Today Activities',
                style: TextStyle(
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
                        child: ListView.builder(
                          itemCount: activities.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 8,
                              ),
                              child: ActivityCard(
                                activity: activities[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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

// dummy activities data
List<Activity> activities = [
  Activity(
    activityId: 0,
    activityName: 'Coding',
    goalTime: 18000, // 5 hours in seconds
    timeSpent: 13000,
    lastTrackedDate: DateTime.now(),
    colorId: 0,
  ),
  Activity(
    activityId: 1,
    activityName: 'Reading',
    goalTime: 7200, // 2 hours in seconds
    timeSpent: 3000,
    lastTrackedDate: DateTime.now(),
    colorId: 1,
  ),
  Activity(
    activityId: 2,
    activityName: 'Exercising',
    goalTime: 3600, // 1 hour in seconds
    timeSpent: 1800,
    lastTrackedDate: DateTime.now(),
    colorId: 2,
  ),
  Activity(
    activityId: 3,
    activityName: 'Writing',
    goalTime: 10800, // 3 hours in seconds
    timeSpent: 1000,
    lastTrackedDate: DateTime.now(),
    colorId: 3,
  ),
  Activity(
    activityId: 4,
    activityName: 'Cooking',
    goalTime: 5400, // 1.5 hours in seconds
    timeSpent: 2000,
    lastTrackedDate: DateTime.now(),
    colorId: 4,
  ),
];
