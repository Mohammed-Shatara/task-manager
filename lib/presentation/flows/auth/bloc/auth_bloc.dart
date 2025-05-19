import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_mediator/bloc_hub/bloc_member.dart';
import 'package:flutter_bloc_mediator/communication_types/base_communication.dart';
import 'package:meta/meta.dart';
import 'package:task_manager/app/di.dart';
import 'package:task_manager/core/blocs/app_bloc/app_bloc.dart';
import 'package:task_manager/domain/use_cases/auth/login_use_case.dart';
import 'package:task_manager/domain/use_cases/auth/register_use_case.dart';
import 'package:task_manager/domain/use_cases/auth/validations/login_validator_use_case.dart';
import 'package:task_manager/domain/use_cases/auth/validations/register_validator_use_case.dart';

import '../../../../core/services/session_manager.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with BlocMember {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final SessionManager sessionManager;
  final LoginValidatorUseCase loginValidatorUseCase;
  final RegisterValidatorUseCase registerValidatorUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.sessionManager,
    required this.loginValidatorUseCase,
    required this.registerValidatorUseCase,
  }) : super(AuthState()) {
    on<SetLoginDataEvent>(_onSetLoginData);
    on<SetRegisterDataEvent>(_onSetRegisterData);
    on<ResetLoginState>(_onResetLoginState);
    on<ResetRegisterState>(_onResetRegisterState);
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ResetLoginErrorState>(_onResetLoginErrorState);
    on<ResetRegisterErrorState>(_onResetRegisterErrorState);
  }

  @override
  void receive(String from, CommunicationType data) {
    // TODO: implement receive
  }
}

extension AuthBlocMappers on AuthBloc {
  void _onSetLoginData(SetLoginDataEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        loginState: state.loginState.copyWith(email: event.email, password: event.password),
      ),
    );
  }

  void _onSetRegisterData(SetRegisterDataEvent event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        registerState: state.registerState.copyWith(
          fullName: event.fullName,
          email: event.email,
          password: event.password,
        ),
      ),
    );
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    final loginParams = LoginParams(
      email: state.loginState.email,
      password: state.loginState.password,
    );

    final validate = loginValidatorUseCase(loginParams);

    if (validate.hasDataOnly) {
      emit(
        state.copyWith(
          loginState: state.loginState.copyWith(status: PageStatus.loading, valid: true),
        ),
      );
      final result = await loginUseCase(loginParams);
      if (result.hasDataOnly) {
        sessionManager.persistToken(result.data!.id.toString());
        emit(state.copyWith(loginState: state.loginState.copyWith(status: PageStatus.success)));
        sendTo(AppStatus(data: Status.authorized), BlocMembersNames.appBloc);
      } else {
        emit(
          state.copyWith(
            loginState: state.loginState.copyWith(
              status: PageStatus.error,
              error: result.error.toString(),
            ),
          ),
        );
      }
    } else {
      emit(state.copyWith(loginState: state.loginState.copyWith(valid: false)));
    }
  }

  void _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    final registerParams = RegisterParams(
      fullName: state.registerState.fullName,
      email: state.registerState.email,
      password: state.registerState.password,
    );

    final validate = registerValidatorUseCase(registerParams);

    if (validate.hasDataOnly) {
      emit(
        state.copyWith(
          registerState: state.registerState.copyWith(status: PageStatus.loading, valid: true),
        ),
      );

      final result = await registerUseCase(registerParams);
      if (result.hasDataOnly) {
        sessionManager.persistToken(result.data!.id.toString());
        emit(
          state.copyWith(registerState: state.registerState.copyWith(status: PageStatus.success)),
        );
        sendTo(AppStatus(data: Status.authorized), BlocMembersNames.appBloc);
      } else {
        emit(
          state.copyWith(
            registerState: state.registerState.copyWith(
              status: PageStatus.error,
              error: result.error.toString(),
            ),
          ),
        );
      }
    } else {
      emit(state.copyWith(registerState: state.registerState.copyWith(valid: false)));
    }
  }

  void _onResetLoginState(ResetLoginState event, Emitter<AuthState> emit) {
    emit(state.copyWith(loginState: LoginState()));
  }

  void _onResetLoginErrorState(ResetLoginErrorState event, Emitter<AuthState> emit) {
    emit(state.copyWith(loginState: state.loginState.copyWith(error: '', status: PageStatus.init)));
  }

  void _onResetRegisterState(ResetRegisterState event, Emitter<AuthState> emit) {
    emit(state.copyWith(registerState: RegisterState()));
  }

  void _onResetRegisterErrorState(ResetRegisterErrorState event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        registerState: state.registerState.copyWith(error: '', status: PageStatus.init),
      ),
    );
  }
}

extension AuthBlocActions on AuthBloc {
  void setLoginData({String? email, String? password}) {
    add(SetLoginDataEvent(email: email, password: password));
  }

  void setRegisterData({String? fullName, String? email, String? password}) {
    add(SetRegisterDataEvent(fullName: fullName, email: email, password: password));
  }

  void login() {
    add(LoginEvent());
  }

  void register() {
    add(RegisterEvent());
  }

  void resetLoginState() {
    add(ResetLoginState());
  }

  void resetLoginErrorState() {
    add(ResetLoginErrorState());
  }

  void resetRegisterState() {
    add(ResetRegisterState());
  }

  void resetRegisterErrorState() {
    add(ResetRegisterErrorState());
  }
}
