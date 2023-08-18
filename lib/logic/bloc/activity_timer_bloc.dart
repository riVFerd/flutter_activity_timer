import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_activity_timer/logic/repository/activity_repository.dart';
import 'package:flutter_activity_timer/logic/repository/sql_activity_repository.dart';
import 'package:meta/meta.dart';

import '../models/activity.dart';

part 'activity_timer_event.dart';
part 'activity_timer_state.dart';

class ActivityTimerBloc extends Bloc<ActivityTimerEvent, ActivityTimerState> {
  ActivityTimerBloc() : super(ActivityTimerInitial()) {
    Timer? timer;
    on<ActivityTimerStarted>((event, emit) {
      emit(ActivityTimerRunning(activity: event.activity));
      timer?.cancel();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        Activity updatedActivity = event.activity.copyWith(
            timeSpent: event.activity.timeSpent + timer.tick,
          );
        if (event.activity.ratioPercentage != 0.0) {
          add(ActivityTimerTick(activity: updatedActivity));
        } else {
          timer.cancel();
          add(ActivityTimerStopped(activity: updatedActivity));
        }
      });
    });
    on<ActivityTimerStopped>((event, emit) async {
      timer?.cancel();
      ActivityRepository repository =
          await SQLActivityRepository.getRepository();
      await repository.updateActivity(event.activity);
      emit(ActivityTimerPaused(activity: event.activity));
    });
    on<ActivityTimerTick>((event, emit) {
      emit(ActivityTimerRunning(activity: event.activity));
    });
  }
}
