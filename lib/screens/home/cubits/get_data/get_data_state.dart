part of 'get_data_cubit.dart';

sealed class GetDataState {}

final class GetDataInitial extends GetDataState {}

class GetAllDataLoadedState extends GetDataState {
 final List<OrderModel> data;
  GetAllDataLoadedState({required this.data});
}

class GetAllDataErrorState extends GetDataState {

}


