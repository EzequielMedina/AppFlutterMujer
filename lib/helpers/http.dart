import 'package:appcuidatemujer/helpers/http_response.dart';
import 'package:dio/dio.dart';

class Http {
  Dio? _dio;
  //final Logger _logger;
  bool? _logsEnabled;

  Http({required Dio? dio, required bool? logsEnabled}) {
    _dio = dio;
    _logsEnabled = logsEnabled;
  }

  Future<HttpResponse<T>> request<T>(
    String path, {
    String method = 'POST',
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await _dio!.request(
        path,
        options: Options(method: method, headers: headers),
        queryParameters: queryParameters,
        data: data,
      );
      //_logger.i(response.data);
      if(parser != null){

        return HttpResponse.success<T>(parser(response.data));
      }

      return HttpResponse.success<T>(response.data);
    } catch (e) {
      //_logger.e(e);
      int statusCode = 0; //errores sin acceso a internet
      String message = "error desconocido";
      dynamic data;
      if (e is DioError) {
        statusCode = -1;
        message = e.message;
        if (e.response != null) {
          statusCode = e.response!.statusCode!;
          message = e.response!.statusMessage!;
          data = e.response!.data!;
        }
      }
      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
