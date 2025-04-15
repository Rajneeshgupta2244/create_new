import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:developer';
class ApiService {
  static final ApiService instance = ApiService._internal();
  factory ApiService() => instance;

  late Dio _dio;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://yourapi.com/api", // Set your API base URL
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {"Accept": "application/json"},
      ),
    );

    // Interceptors for logging requests, responses, and errors
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        log("➡️ Request: \${options.method} \${options.uri}");
        log("Headers: \${options.headers}");
        if (options.data != null) log("Body: \${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log("✅ Response (\${response.statusCode}): \${response.data}");
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        log("❌ Error (\${e.response?.statusCode}): \${e.message}");
        if (e.response?.statusCode == 401) {
          _handleUnauthorized();
        }
        return handler.next(e);
      },
    ));
  }

  /// Handles unauthorized requests (e.g., logout user)
  void _handleUnauthorized() {
    log("⚠️ Unauthorized access detected! Logging out user...");
    // Implement logout logic (e.g., clear token, redirect to login)
  }

  /// Sets authentication token for secure API requests
  void setAuthToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer \$token";
  }

  /// Clears authentication token (e.g., on logout)
  void clearAuthToken() {
    _dio.options.headers.remove("Authorization");
  }

  /// Generic GET request
  Future<Response?> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(endpoint, queryParameters: params);
    } catch (e) {
      log("GET Error: \$e");
      return null;
    }
  }

  /// Generic POST request
  Future<Response?> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      log("POST Error: \$e");
      return null;
    }
  }

  /// Generic PUT request
  Future<Response?> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } catch (e) {
      log("PUT Error: \$e");
      return null;
    }
  }

  /// Generic DELETE request
  Future<Response?> delete(String endpoint) async {
    try {
      return await _dio.delete(endpoint);
    } catch (e) {
      log("DELETE Error: \$e");
      return null;
    }
  }

  /// Upload a single file
  Future<Response?> uploadFile(String endpoint, File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      return await _dio.post(endpoint, data: formData);
    } catch (e) {
      log("File Upload Error: \$e");
      return null;
    }
  }

  /// Upload multiple files
  Future<Response?> uploadMultipleFiles(String endpoint, List<File> files) async {
    try {
      List<MultipartFile> multipartFiles = [];
      for (var file in files) {
        String fileName = file.path.split('/').last;
        multipartFiles.add(await MultipartFile.fromFile(file.path, filename: fileName));
      }

      FormData formData = FormData.fromMap({"files": multipartFiles});

      return await _dio.post(endpoint, data: formData);
    } catch (e) {
      log("Multiple Files Upload Error: \$e");
      return null;
    }
  }
}
