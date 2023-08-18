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
}
