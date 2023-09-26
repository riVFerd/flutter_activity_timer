part of 'activity_timer_bloc.dart';

@immutable
abstract class ActivityTimerState extends Equatable {
  final Activity? activity;

  const ActivityTimerState({this.activity});

  @override
  List<Object?> get props => [activity];
}

class ActivityTimerInitial extends ActivityTimerState {}

class ActivityTimerRunning extends ActivityTimerState {
  const ActivityTimerRunning({required super.activity});

  @override
  List<Object?> get props => [activity];
}

class ActivityTimerPaused extends ActivityTimerState {
  const ActivityTimerPaused({required super.activity});

  @override
  List<Object?> get props => [activity];
}
