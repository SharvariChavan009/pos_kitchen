part of 'get_data_cubit.dart';

sealed class GetDataState {}

final class GetDataInitial extends GetDataState {}

class GetPlacedDataLoadedState extends GetDataState {
  final List<OrderModel> placedList;
  GetPlacedDataLoadedState({required this.placedList});
}

class GetAllDataErrorState extends GetDataState {}

