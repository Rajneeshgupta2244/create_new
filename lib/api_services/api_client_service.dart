import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
class ApiClient {
  final Dio _dio = Dio();
  String? _token;

  ApiClient() {
    _dio.options.baseUrl = "https://your-api-base-url.com/api";
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token != null) {
            options.headers["Authorization"] = "Bearer $_token";
          }

          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (DioException e, handler) {
          if (e.response != null) {
          }
          handler.next(e);
        },
      ),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ]);
  }

  void setToken(String token) {
    _token = token;
  }

  // ==================== API Methods ====================

  Future<Response?> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(path, queryParameters: queryParams);
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<Response?> post(String path, {dynamic data, Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.post(path, data: data, queryParameters: queryParams);
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<Response?> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<Response?> delete(String path, {dynamic data}) async {
    try {
      return await _dio.delete(path, data: data);
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // ==================== Error Handling ====================

  void _handleError(DioException e) {
    final statusCode = e.response?.statusCode;

    switch (statusCode) {
      case 400:
        debugPrint("⚠️ Bad Request: ${e.response?.data}");
        break;
      case 401:
        debugPrint("🔒 Unauthorized: Token may be expired");
        break;
      case 403:
        debugPrint("🚫 Forbidden: Access denied");
        break;
      case 404:
        debugPrint("❓ Not Found: ${e.response?.data}");
        break;
      case 500:
        debugPrint("💥 Server Error");
        break;
      default:
        debugPrint("❗ Unknown Error: ${e.message}");
        break;
    }
  }
}
