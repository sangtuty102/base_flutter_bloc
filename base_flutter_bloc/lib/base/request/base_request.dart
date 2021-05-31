// request với DIO
import 'dart:io';

import 'package:base_flutter_bloc/app_bloc/app_bloc.dart';
import 'package:base_flutter_bloc/base/locator/get_it.dart';
import 'package:base_flutter_bloc/const/all_const.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

enum RequestMethod { POST, GET }

const DEFAULT_CACHE_DURATION = 7;

class BaseRequest {
  static Dio dio = getBaseDio();

  static Dio getBaseDio() {
    Dio dio = Dio();

    dio.options.connectTimeout = AppConst.requestTimeOut;
    dio.options.receiveTimeout = AppConst.requestTimeOut;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return dio;
  }

  static void close() {
    dio.close(force: true);
    updateCurrentDio();
  }

  static void updateCurrentDio() {
    dio = getBaseDio();
  }

  static Dio getCurrentDio() {
    return dio;
  }

  Future<dynamic> sendRequest(String action, RequestMethod requestMethod,
      {Map<String, dynamic> jsonMap, bool buildCacheOptions = false}) async {
    Response response;

    if (buildCacheOptions) {
      dio.interceptors.add(GetIt.I<DioCacheManager>().interceptor);
    }

    Map<String, String> headers = await getBaseHeader();
    Options options = buildCacheOptions
        ? _buildCacheOptions(headers, requestMethod)
        : Options(
            headers: headers,
            method: requestMethod.toString(),
            responseType: ResponseType.json);

    if (requestMethod == RequestMethod.POST) {
      response = await dio.post(action, data: jsonMap, options: options);
    } else if (requestMethod == RequestMethod.GET) {
      response =
          await dio.get(action, queryParameters: jsonMap, options: options);
    }
    return response.data;
  }

  Future<Map<String, String>> getBaseHeader() async {
    String _token = HIVE_APP.get(AppConst.keyTokenAcount, defaultValue: '');

    return {
      "Content-Type": "application/json",
      'Authorization': _token,
    };
  }

  Options _buildCacheOptions(
      Map<String, String> headers, RequestMethod requestMethod) {
    return buildCacheOptions(Duration(days: DEFAULT_CACHE_DURATION),
        maxStale: Duration(days: DEFAULT_CACHE_DURATION),
        options: Options(
            headers: headers,
            method: requestMethod.toString(),
            responseType: ResponseType.json),
        forceRefresh: false);
  }
}
