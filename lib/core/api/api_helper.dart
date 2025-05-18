import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../enums/api/HttpMethod.dart';
import '../error/base_error.dart';
import '../error/connection/socket_error.dart';
import '../error/connection/unknown_error.dart';
import '../error/http/unauthorized_error.dart';
import '../error/http/forbidden_error.dart';
import 'auth_interceptor.dart';
import 'handler.dart';

class ApiHelper with ErrorHandler, RefreshableRequest {
  Future<Either<BaseError, T>> sendRequest<T>({
    required HttpMethod method,
    required String url,
    required T Function(dynamic) mapper,
    Map<String, dynamic> data = const {},
    FormData? data1,
    Map<String, String> headers = const {},
    CancelToken? cancelToken,
    bool withRefreshToken = true,
  }) async {
    print('withRefreshToken: $withRefreshToken');
    Dio dio = withRefreshToken ? getRefreshableDio() : Dio();

    try {
      late Response response;

      switch (method) {
        case HttpMethod.get:
          log(
            'method: [$method] url: [$url] data: [$data] headers: [$headers]',
          );

          response = await dio.get(
            url,
            queryParameters: data,
            options: Options(
              sendTimeout: const Duration(minutes: 30),
              headers: headers,
              followRedirects: false,
              validateStatus: (status) {
                return status! <= 500 && status != 403 && status != 401;
              },
            ),
            cancelToken: cancelToken,
          );
          break;

        case HttpMethod.post:
          log('method: [$method] url: [$url] data: [$data]');

          response = await dio.post(
            url,
            data: json.encode(data),
            options: Options(
              headers: headers,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500 && status != 403;
              },
            ),
            // cancelToken: cancelToken,
          );

          break;
        case HttpMethod.put:
          response = await dio.put(
            url,
            data: data,
            queryParameters: data,
            options: Options(
              headers: headers,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500 && status != 403;
              },
            ),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.patch:
          log('method: [$method] url: [$url] data: [$data]');

          response = await dio.patch(
            url,
            data: data1 ?? data,
            //   queryParameters: data,
            options: Options(
              headers: headers,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500 && status != 403;
              },
            ),
            cancelToken: cancelToken,
          );
          break;
        case HttpMethod.delete:
          log('method: [$method] url: [$url] data: [$data]');

          response = await dio.delete(
            url,
            data: FormData.fromMap(data),
            queryParameters: data,
            options: Options(
              headers: headers,
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500 && status != 401 && status != 403;
              },
            ),
            cancelToken: cancelToken,
          );
          break;
        default:
          break;
      }
      log('response: $response');

      return Right(mapper(response));
    } on DioException catch (e, stacktrace) {
      log('DioException,$e $stacktrace');
      BaseError error = _handleError(e);
      if ((error is ForbiddenError) || (error is UnauthorizedError)) {
        throw ForbiddenError();
      }
      return Left(error);
    } on SocketException {
      print('SocketException');

      return Left(SocketError());
    } catch (e, stacktrace) {
      if (e is ForbiddenError) throw ForbiddenError();
      print('stacktrace $e $stacktrace');
      return Left(UnknownError());
    }
  }

  _handleError(error) => handleError(error);
}
