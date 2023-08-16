class Activity {
  final int activityId;
  final String activityName;
  final int goalTime;
  final int timeSpent;
  final DateTime lastTrackedDate;
  final int colorId;

  Activity({
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
}
