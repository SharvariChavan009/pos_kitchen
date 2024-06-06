part of 'ready_data_cubit.dart';

@immutable
sealed class ReadyDataState {}

final class ReadyDataInitial extends ReadyDataState {}

class ReadyDataErrorState extends ReadyDataState {}

class ReadyDataLoadedState extends ReadyDataState {
  final List<OrderModel> readyList;
  ReadyDataLoadedState({required this.readyList});
}

