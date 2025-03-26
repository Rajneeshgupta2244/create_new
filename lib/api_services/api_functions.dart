import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'api_end_points.dart';

class ApiBaseHelper {
  Future<dynamic> apiCall({
    required Uri url,
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    log(url.toString());
    if (body != null) {
      print("::::Request Parameter======$body");
    }

    http.Response response;
    try {
      if (method.toUpperCase() == 'POST') {
        response = await http.post(
          url,
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
      } else if (method.toUpperCase() == 'GET') {
        response = await http.get(url, headers: headers);
      } else if (method.toUpperCase() == 'PUT') {
        response = await http.put(
          url,
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
      } else if (method.toUpperCase() == 'DELETE') {
        response = await http.delete(url, headers: headers);
      } else {
        throw Exception('Unsupported HTTP method');
      }

      log("==Api Data ::=========${jsonDecode(response.body)}============");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  ///For Perm Request
  Future<dynamic> apiCallWithPerm({
    required String urlEndPost,
    required String method,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    log('url====$baseUrl${urlEndPost.toString()}');
    if (body != null) {
      print("::::Request Parameter======$body");
    }

    http.Response response;
    try {
      if (method.toUpperCase() == 'POST') {
        response = await http.post(
          Uri.parse('$baseUrl${urlEndPost.toString()}'),
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
      } else if (method.toUpperCase() == 'GET') {
        response = await http.get(
          Uri.parse('$baseUrl${urlEndPost.toString()}'),
          headers: headers,
        );
      } else if (method.toUpperCase() == 'PUT') {
        response = await http.put(
          Uri.parse('$baseUrl${urlEndPost.toString()}'),
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
      } else if (method.toUpperCase() == 'DELETE') {
        response = await http.delete(
          Uri.parse('$baseUrl${urlEndPost.toString()}'),
          headers: headers,
        );
      } else {
        throw Exception('Unsupported HTTP method');
      }
      log("==Api Data ::=========${jsonDecode(response.body)}============");

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
