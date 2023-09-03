import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/presentation/theme/card_constants.dart';

import '../../logic/models/activity.dart';
import '../screens/activity_screen.dart';
import '../theme/theme_constants.dart';
import 'input_activity_modal.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: CardConstants.backgroundColors[activity.colorId],
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(
            ActivityScreen.routeName,
            arguments: activity,
          ),
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: ThemeConstants.darkBlue,
              builder: (context) {
                return InputActivityModal(activity: activity);
              },
            );
          },
          overlayColor: MaterialStateProperty.all(
            Colors.white.withOpacity(0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  activity.activityName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Hero(
                  tag: activity.activityId,
                  child: CircularProgressIndicator(
                    value: activity.ratioPercentage,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    backgroundColor: Colors.white.withOpacity(0.3),
                    strokeWidth: 8,
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
