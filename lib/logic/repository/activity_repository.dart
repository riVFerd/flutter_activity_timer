import '../models/activity.dart';

abstract class ActivityRepository {
  Future<void> insertActivity(Activity activity);
  Future<List<Activity>> getActivities();
  Future<void> updateActivity(Activity activity);
  Future<void> deleteActivity(int id);
  Future<void> close();
}
