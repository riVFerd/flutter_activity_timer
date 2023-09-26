import 'package:flutter/material.dart';

class Activity {
  final int activityId;
  final String activityName;

  /// Time in seconds
  final int goalTime;

  /// Time in seconds
  final int timeSpent;
  final DateTime lastTrackedDate;
  final int colorId;

  const Activity({
    required this.activityId,
    required this.activityName,
    required this.goalTime,
    required this.timeSpent,
    required this.lastTrackedDate,
    required this.colorId,
  });

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      activityId: map['activityId'],
      activityName: map['activityName'],
      goalTime: map['goalTime'],
      timeSpent: map['timeSpent'],
      lastTrackedDate: DateTime.parse(map['lastTrackedDate']),
      colorId: map['colorId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'activityId': activityId,
      'activityName': activityName,
      'goalTime': goalTime,
      'timeSpent': timeSpent,
      'lastTrackedDate': lastTrackedDate.toIso8601String(),
      'colorId': colorId,
    };
  }

  Activity copyWith({
    int? activityId,
    String? activityName,
    int? goalTime,
    int? timeSpent,
    DateTime? lastTrackedDate,
    int? colorId,
  }) {
    return Activity(
      activityId: activityId ?? this.activityId,
      activityName: activityName ?? this.activityName,
      goalTime: goalTime ?? this.goalTime,
      timeSpent: timeSpent ?? this.timeSpent,
      lastTrackedDate: lastTrackedDate ?? this.lastTrackedDate,
      colorId: colorId ?? this.colorId,
    );
  }

  /// Convert [TimeOfDay] to seconds
  static int toSecond(TimeOfDay time) {
    return time.hour * 3600 + time.minute * 60;
  }

  /// Get ratio percentage of time spent and goal time in reverse.
  /// The value is between 0.0 and 1.0.
  /// The more time spent, the lower the percentage.
  double get ratioPercentage {
    return (goalTime - timeSpent) / goalTime;
  }

  /// Get percentage of time spent and goal time in reverse as a string.
  /// The value is between 00.0 and 100.0.
  /// The more time spent, the lower the percentage.
  String get percentage {
    return (ratioPercentage * 100).toStringAsFixed(1);
  }


  /// Get remaining time from [timeSpent] and [goalTime].
  /// The more time spent, the lower the remaining time.
  int get hours {
    return (goalTime - timeSpent) ~/ 3600;
  }

  /// Get remaining time from [timeSpent] and [goalTime].
  /// The more time spent, the lower the remaining time.
  int get minutes {
    return (goalTime - timeSpent) % 3600 ~/ 60;
  }

  /// Get remaining time from [timeSpent] and [goalTime].
  /// The more time spent, the lower the remaining time.
  int get seconds {
    return (goalTime - timeSpent) % 3600 % 60;
  }
}
