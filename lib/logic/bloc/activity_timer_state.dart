part of 'activity_timer_bloc.dart';

@immutable
sealed class ActivityTimerState {
  final Activity? activity;

  const ActivityTimerState({this.activity});
}

final class ActivityTimerInitial extends ActivityTimerState {}

final class ActivityTimerRunning extends ActivityTimerState {
  const ActivityTimerRunning({required super.activity});
}

final class ActivityTimerPaused extends ActivityTimerState {
  const ActivityTimerPaused({required super.activity});
}