part of 'auth_bloc.dart';

@immutable
class AuthState extends Equatable {
  final LoginState loginState;
  final RegisterState registerState;

  const AuthState({
    this.loginState = const LoginState(),
    this.registerState = const RegisterState(),
  });

  AuthState copyWith({LoginState? loginState, RegisterState? registerState}) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      registerState: registerState ?? this.registerState,
    );
  }

  @override
  List<Object?> get props => [loginState, registerState];
}

class LoginState extends Equatable {
  final PageStatus status;
  final String email;
  final String password;
  final String error;
  final bool? valid;

  const LoginState({
    this.status = PageStatus.init,
    this.email = '',
    this.password = '',
    this.valid,
    this.error = '',
  });

  LoginState copyWith({
    PageStatus? status,
    String? email,
    String? password,
    String? error,
    bool? valid,
  }) {
    return LoginState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
      valid: valid ?? this.valid,
    );
  }

  @override
  List<Object?> get props => [status, email, password, error, valid];
}

class RegisterState extends Equatable {
  final PageStatus status;
  final String fullName;
  final String email;
  final String password;
  final String error;
  final bool? valid;

  const RegisterState({
    this.status = PageStatus.init,
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.error = '',
    this.valid,
  });

  RegisterState copyWith({
    PageStatus? status,
    String? fullName,
    String? email,
    String? password,
    String? error,
    bool? valid,
  }) {
    return RegisterState(
      status: status ?? this.status,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
      valid: valid ?? this.valid,
    );
  }

  @override
  List<Object?> get props => [status, fullName, email, password, valid];
}
