import 'package:dio/dio.dart';

class NetworkHelper {
  static Future<Response> getData(String url, {dynamic headers}) async =>
      await Dio(BaseOptions(headers: headers)).get(url);

  static Future<Response> sendData(String url,
          {dynamic data, dynamic headers}) async =>
      await Dio(BaseOptions(headers: headers)).post(
        url,
        data: data,
      );
}
