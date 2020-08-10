import 'package:dio/dio.dart';

class NetworkHelper {
  /// It makes GET HTTP request
  static Future<Response> getData(String url, {dynamic headers}) async =>
      await Dio(BaseOptions(headers: headers)).get(url);

  /// It makes POST HTTP request
  static Future<Response> sendData(String url,
          {dynamic data, dynamic headers}) async =>
      await Dio(BaseOptions(headers: headers)).post(
        url,
        data: data,
      );
}
