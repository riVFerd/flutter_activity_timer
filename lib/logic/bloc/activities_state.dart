part of 'activities_bloc.dart';

@immutable
sealed class ActivitiesState {}

final class ActivitiesInitial extends ActivitiesState {}

final class ActivitiesLoading extends ActivitiesState {}

final class ActivitiesLoaded extends ActivitiesState {
  final List<Activity> activities;

  ActivitiesLoaded(this.activities);
}

final class ActivitiesError extends ActivitiesState {
  final String message;

  ActivitiesError(this.message);
}