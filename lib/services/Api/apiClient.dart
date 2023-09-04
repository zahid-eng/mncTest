import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClientProvider with ChangeNotifier {
  bool _isloading = false;

  bool get authloading => _isloading;

  setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  final Dio _dio = Dio();

  Future<Response?> postRequest(String url, dynamic data,
      {Map<String, dynamic>? headers}) async {
    setLoading(true);
    try {
      final response =
          await _dio.post(url, data: data, options: Options(headers: headers));
      setLoading(false);
      return response;
    } catch (error) {
      print("POST Request Error: $error");
      setLoading(false);
      return null;
    }
  }

  Future<Response?> getRequest(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    setLoading(true);
    try {
      final response = await _dio.get(url,
          queryParameters: queryParameters, options: Options(headers: headers));
      setLoading(false);
      return response;
    } catch (error) {
      setLoading(false);
      print("GET Request Error: $error");
      return null;
    }
  }
}
