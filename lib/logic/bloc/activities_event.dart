part of 'activities_bloc.dart';

@immutable
sealed class ActivitiesEvent {}

final class ActivitiesLoad extends ActivitiesEvent {}

final class ActivitiesAdd extends ActivitiesEvent {
  final Activity activity;

  ActivitiesAdd(this.activity);
}

final class ActivitiesDelete extends ActivitiesEvent {
  final Activity activity;

  ActivitiesDelete(this.activity);
}

final class ActivitiesUpdate extends ActivitiesEvent {
  final Activity activity;

  ActivitiesUpdate(this.activity);
}