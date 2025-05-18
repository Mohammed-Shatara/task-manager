import 'package:dartz/dartz.dart';

import '../api/api_helper.dart';
import '../error/base_error.dart';
import '../error/connection/unknown_error.dart';
import '../error/custom_error.dart';

import '../response/api_response.dart';
import '../services/session_manager.dart';
import 'api_call_params.dart';

abstract class RemoteDataSource {
  Future<Either<BaseError, Data>> request<Data, Response extends ApiResponse>(
    ApiCallParams<Response> params,
  ) async {
    final Map<String, String> headers = {};
    if (params.token != null && params.token!.isNotEmpty) {
      headers.putIfAbsent(
        SessionManager.authorizeToken,
        () => 'Bearer ${params.token}',
      );
      // print('token: ${params.token}');
    }
    // final language = await LocalizationManager.getLanguage();

    headers.putIfAbsent('content-Type', () => 'application/json');
    // headers.putIfAbsent('accept-language', () => language.name);
    headers.putIfAbsent('Timezone', () => DateTime.now().timeZoneName);
    print('DateTime.now().timeZoneName: ${DateTime.now().timeZoneName}');
    //  headers['content-Type'] = 'application/json';

    // print('data: ${params.data}');
    final response = await ApiHelper().sendRequest<Response>(
      method: params.method,
      mapper: params.mapper,
      url: params.url,
      data: params.data,
      data1: params.data1,
      headers: headers,
      cancelToken: params.cancelToken,
    );

    print('123 123 Response: $response');

    if (response.isLeft()) {
      BaseError error = (response as Left<BaseError, Response>).value;
      return Left(error);
    } else if (response.isRight()) {
      final resValue = (response as Right<BaseError, Response>).value;
      // print('has error : ${resValue.hasError}');
      if (resValue.hasError) return Left(CustomError(message: resValue.msg));
      return Right(resValue.result);
    }
    return left(UnknownError());
  }
}
