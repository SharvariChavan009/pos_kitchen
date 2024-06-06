part of 'fetch_prepared_data_cubit.dart';

sealed class FetchPreparedDataState {}

final class FetchPreparedDataInitial extends FetchPreparedDataState {}

class GetAllDataErrorState1 extends FetchPreparedDataState {}

class GetPreparedDataLoadedState extends FetchPreparedDataState {
  final List<OrderModel> preparedList;
  GetPreparedDataLoadedState({required this.preparedList});
}
