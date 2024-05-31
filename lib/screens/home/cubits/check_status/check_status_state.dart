part of 'check_status_cubit.dart';

@immutable
sealed class CheckStatusState {}

final class CheckStatusInitial extends CheckStatusState {}

final class CheckStatusPlacedState extends CheckStatusState {
  List<OrderModel> pldata;

  CheckStatusPlacedState({required this.pldata});
}

final class CheckStatusPlacedErrorState extends CheckStatusState {}

final class CheckStatusPreparedState extends CheckStatusState {
  List<OrderModel> predata;

  CheckStatusPreparedState({required this.predata});
}

final class CheckStatusPreparedErrorState extends CheckStatusState {}
