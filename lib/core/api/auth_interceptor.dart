// import 'package:copax/app+injection/di.dart';

import 'package:dio/dio.dart';

// import '../blocs/application_bloc/app_bloc.dart';
// import '../resources/apis.dart';
import '../../app/di.dart';
import '../blocs/app_bloc/app_bloc.dart';
import '../resources/apis.dart';
import '../services/session_manager.dart';

class AuthInterceptor extends Interceptor {
  final SessionManager sessionManager;
  final Dio dio;
  late RequestOptions _previousRequest;

  AuthInterceptor(this.sessionManager, this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await sessionManager.authToken;

    print('RequestInterceptorHandler: token: $token');

    // print('RequestOptions RequestOptions RequestOptions');
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    _previousRequest = options;

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // print('err err err err ${err.error is SocketException} ${err.message} ${err.error} ${err.response?.statusCode?.toString()} ${err.stackTrace} ');
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      final tokens = await Future.wait([
        sessionManager.authToken,
        sessionManager.refreshToken,
      ]);

      try {
        print(
          'RequestInterceptorHandler: ${err.response?.statusCode} token: ${tokens.last} refresh ${tokens.first}',
        );

        final result = await _fetchNewToken(tokens.last, tokens.first);
        //  print(' RequestInterceptorHandler ${result.statusMessage}');
        if (result.statusCode == 201 || result.statusCode == 200) {
          final token = result.data['tokens']['access'];
          final refreshToken = result.data['tokens']['refresh'];

          await sessionManager.persistToken(token);
          await sessionManager.persistRefreshToken(refreshToken);

          _previousRequest.headers['Authorization'] = 'Bearer $token';
          final response = await dio.request(
            _previousRequest.path,
            data: _previousRequest.data,
            options: Options(
              method: _previousRequest.method,
              headers: _previousRequest.headers,
              responseType: _previousRequest.responseType,
              contentType: _previousRequest.contentType,
            ),
          );
          handler.resolve(response);
        } else {
          //   print('result.statusCode: ${result.statusCode}');
          if (result.statusCode == 400) {
            throw DioException.badResponse(
              statusCode: 403,
              requestOptions: result.requestOptions,
              response: Response(
                requestOptions: result.requestOptions,
                statusCode: 403,
              ),
            );
          }
        }
      } on DioException catch (error) {
        handler.next(error);
      }
    } else {
      err.error;
      handler.next(err);
    }
  }

  Future<Response> _fetchNewToken(String refreshToken, String token) async {
    Dio dio = Dio();
    // ${locator<AppBloc>().state.baseUrl}${ApiUrls.refreshToken}
    Response response = await dio.post(
     // '${locator<AppBloc>().state.baseUrl}${ApiUrls.refreshToken}',
      '',
      data: {"token": refreshToken},
      options: Options(
        headers: {
          SessionManager.authorizeToken: 'Bearer $token',
          "refresh-token": refreshToken,
          "content-Type": "application/json",
          "Accept": "application/json",
        },
        validateStatus: (status) {
          return status! < 500 && status != 403 && status != 401;
        },
      ),
    );


    return response;
  }
}

mixin RefreshableRequest {
  final AuthInterceptor authInterceptor = locator<AuthInterceptor>();

  Dio getRefreshableDio() {
    final dio = Dio();
    dio.interceptors.add(authInterceptor);
    return dio;
  }
}
