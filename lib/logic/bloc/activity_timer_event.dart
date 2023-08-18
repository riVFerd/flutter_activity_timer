part of 'activity_timer_bloc.dart';

@immutable
sealed class ActivityTimerEvent {}

final class ActivityTimerStarted extends ActivityTimerEvent {
  final Activity activity;

  ActivityTimerStarted({required this.activity});
}

final class ActivityTimerStopped extends ActivityTimerEvent {
  final Activity activity;

  ActivityTimerStopped({required this.activity});
}

final class ActivityTimerTick extends ActivityTimerEvent {
  final Activity activity;

  ActivityTimerTick({required this.activity});
}
