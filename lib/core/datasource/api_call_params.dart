import 'package:dio/dio.dart';

import '../enums/api/HttpMethod.dart';

class ApiCallParams<Response> {
  final String responseStr;
  final Response Function(dynamic) mapper;
  final HttpMethod method;
  final String url;
  final Map<String, String>? queryParameters;
  final Map<String, dynamic> data;
  final FormData? data1;
  String? token;
  final CancelToken? cancelToken;
  final String acceptLang;
  final String? refreshCaller;
  final String? refreshToken;

  ApiCallParams({
    required this.responseStr,
    required this.mapper,
    required this.method,
    required this.url,
    this.queryParameters,
    this.refreshToken,
    this.data1,
    this.refreshCaller,
    this.data = const {},
    this.token,
    this.cancelToken,
    this.acceptLang = 'en',
  });

  ApiCallParams changeToken(String token) {
    this.token = token;
    return this;
  }
}
