part of 'app_bloc.dart';

enum Status { startup, authorized, unauthorized, dynamicLogin }

class AppState extends Equatable {
  const AppState({
    this.isLaunched = false,
    this.isFirstTime = false,
    // this.me,
    this.appStatus = Status.startup,
    this.baseUrl,
    this.isError = false,
    this.isProfileFilled = true,
    this.token,
    this.error = '',
  });

  final bool isFirstTime;
  final bool isLaunched;
  final String? baseUrl;
  final String? token;

  final Status appStatus;

  final bool isProfileFilled;

  final bool isError;
  final String error;
  // final Me? me;

  AppState copyWith({
    bool? isLaunched,
    Status? appStatus,
    String? error,
    String? baseUrl,
    bool? isFirstTime,
    // Me? me,
    String? token,
    bool? isError,
    bool? isProfileFilled,
  }) {
    return AppState(
      isLaunched: isLaunched ?? this.isLaunched,
      isError: isError ?? this.isError,
      error: error ?? this.error,
      baseUrl: baseUrl ?? this.baseUrl,
      token: token ?? this.token,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      appStatus: appStatus ?? this.appStatus,
      isProfileFilled: isProfileFilled ?? this.isProfileFilled,
      // me: me?? this.me,
    );
  }

  @override
  List<Object?> get props => [
    isLaunched,
    isFirstTime,
    appStatus,
    isError,
    error,
    isProfileFilled,
    baseUrl,
    // me,
    token,
  ];
}
