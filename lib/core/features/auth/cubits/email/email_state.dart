part of 'email_cubit.dart';

sealed class EmailState extends Equatable {
  const EmailState();

  @override
  List<Object> get props => [];
}

final class EmailInitial extends EmailState {}

class EmailValidatorState extends EmailState {
  String errorMessage2;

  EmailValidatorState({required this.errorMessage2});
}
