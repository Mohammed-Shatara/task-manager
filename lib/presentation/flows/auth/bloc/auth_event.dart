part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {}

class SetLoginDataEvent extends AuthEvent {
  final String? email;
  final String? password;

  SetLoginDataEvent({this.email, this.password});
}

class SetRegisterDataEvent extends AuthEvent {
  final String? fullName;
  final String? email;
  final String? password;

  SetRegisterDataEvent({this.fullName, this.email, this.password});
}


class ResetLoginState extends AuthEvent {}
class ResetLoginErrorState extends AuthEvent {}
class ResetRegisterState extends AuthEvent {}
class ResetRegisterErrorState extends AuthEvent {}