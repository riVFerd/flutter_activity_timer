import 'package:flutter_activity_timer/logic/models/activity.dart';
import 'package:flutter_activity_timer/logic/repository/activity_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLActivityRepository implements ActivityRepository {
  static late final Database _db;
  final tableName = 'activity';

  SQLActivityRepository() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'activity_timer_database.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          '''
            CREATE TABLE $tableName(
              activityId INTEGER PRIMARY KEY,
              activityName TEXT NOT NULL,
              goalTime INTEGER NOT NULL,
              timeSpent INTEGER NOT NULL,
              lastTrackedDate TEXT NOT NULL,
              colorId INTEGER NOT NULL
            )
          ''',
        );
      },
    );
  }

  @override
  Future<void> close() async {
    _db.close();
  }

  @override
  Future<void> deleteActivity(int id) async {
    _db.delete(
      tableName,
      where: 'activityId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Activity>> getActivities() async {
    late List<Activity> activites;
    List<Map<String, dynamic>> maps = await _db.query(tableName);
    activites = maps.map((activity) => Activity.fromMap(activity)).toList();
    return activites;
  }

  @override
  Future<void> insertActivity(Activity activity) async {
    _db.insert(
      tableName,
      activity.toMap(),
    );
  }

  @override
  Future<void> updateActivity(Activity activity) async {
    _db.update(
      tableName,
      activity.toMap(),
      where: 'activityId = ?',
      whereArgs: [activity.activityId],
    );
  }
}
