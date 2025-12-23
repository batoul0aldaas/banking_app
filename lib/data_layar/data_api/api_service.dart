import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final Map<String, String> baseHeaders = {
    "Accept": "application/json",
    "Accept-Language": "ar",
  };

  Future<Map<String, dynamic>> get(
    String url, {
    String? token,
    Map<String, dynamic>? queryParameters,
  }) async {
    final headers = Map<String, String>.from(baseHeaders);
    if (token != null && token.trim().isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }

    try {
      Uri uri = Uri.parse(url);
      if (queryParameters != null && queryParameters.isNotEmpty) {
        uri = uri.replace(
          queryParameters: queryParameters.map(
            (k, v) => MapEntry(k, v.toString()),
          ),
        );
      }

      final response = await http.get(uri, headers: headers);
      return _processResponse(response);
    } catch (e) {
      throw "فشل الاتصال بالسيرفر: $e";
    }
  }

  Future<Map<String, dynamic>> post(
    String url, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final headers = Map<String, String>.from(baseHeaders);
    if (token != null && token.trim().isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body?.map((k, v) => MapEntry(k, v.toString())),
      );
      return _processResponse(response);
    } catch (e) {
      throw "فشل الاتصال بالسيرفر: $e";
    }
  }

  Future<Map<String, dynamic>> postMultipart(
    String url, {
    required Map<String, dynamic> fields,
    String? token,
  }) async {
    final headers = Map<String, String>.from(baseHeaders);
    if (token != null && token.trim().isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }

    try {
      final req = http.MultipartRequest("POST", Uri.parse(url));
      req.headers.addAll(headers);

      fields.forEach((k, v) {
        if (v == null) return;
        req.fields[k] = v.toString();
      });

      final streamed = await req.send();
      final response = await http.Response.fromStream(streamed);
      return _processResponse(response);
    } catch (e) {
      throw "فشل الاتصال بالسيرفر: $e";
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    print("API RESPONSE (${response.statusCode}): ${response.body}");

    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      throw "الاستجابة من السيرفر ليست بيانات JSON صالحة";
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded as Map<String, dynamic>;
    } else {
      final message = (decoded is Map<String, dynamic>)
          ? (decoded["message"] ?? decoded["error"] ?? "حدث خطأ غير معروف")
          : "حدث خطأ غير معروف";
      throw message.toString();
    }
  }
}
