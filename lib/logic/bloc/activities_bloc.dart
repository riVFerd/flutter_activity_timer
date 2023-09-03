import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_activity_timer/logic/repository/activity_repository.dart';
import 'package:flutter_activity_timer/logic/repository/sql_activity_repository.dart';

import '../models/activity.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  ActivitiesBloc() : super(ActivitiesInitial()) {
    on<ActivitiesLoad>((event, emit) async {
      emit(ActivitiesLoading());
      try {
        ActivityRepository activityRepository =
            await SQLActivityRepository.getRepository();
        final activities = await activityRepository.getActivities();
        emit(ActivitiesLoaded(activities));
      } catch (e) {
        // print(e);
      }
    });
    on<ActivitiesAdd>((event, emit) async {
      emit(ActivitiesLoading());
      try {
        ActivityRepository activityRepository =
            await SQLActivityRepository.getRepository();
        activityRepository.insertActivity(event.activity);
        add(ActivitiesLoad());
      } catch (e) {
        // print(e);
      }
    });
    on<ActivitiesDelete>((event, emit) async {
      emit(ActivitiesLoading());
      try {
        ActivityRepository activityRepository =
            await SQLActivityRepository.getRepository();
        activityRepository.deleteActivity(event.activity.activityId);
        add(ActivitiesLoad());
      } catch (e) {
        // print(e);
      }
    });
    on<ActivitiesUpdate>((event, emit) async {
      emit(ActivitiesLoading());
      try {
        ActivityRepository activityRepository =
            await SQLActivityRepository.getRepository();
        activityRepository.updateActivity(event.activity);
        add(ActivitiesLoad());
      } catch (e) {
        // print(e);
      }
    });
  }
}
