import 'package:appcuidatemujer/helpers/http_response.dart';
import 'package:appcuidatemujer/models/authetication_response.dart';
import 'package:dio/dio.dart';
//import 'package:logger/logger.dart';
import '../helpers/http.dart';

class AuthenticationApi {
  final Http _http;

  AuthenticationApi(this._http);
  Future<HttpResponse<AutheticationResponse>> register({
    required String usuario,
    required String email,
    required String password,
  }) {
    return _http.request<AutheticationResponse>(
      '/api/auth/register',
      method: 'POST',
      data: {
        "username": usuario,
        "email": email,
        "password": password,
      },
      parser: (data) {
        return AutheticationResponse.fromJson(data);
      },
    );
  }

  Future<HttpResponse<AutheticationResponse>> login({
    required String email,
    required String password,
  }) {
    return _http.request<AutheticationResponse>(
      '/api/auth/login',
      method: 'POST',
      data: {
        "email": email,
        "password": password,
      },
      parser: (data) {
        return AutheticationResponse.fromJson(data);
      },
    );
  }

  Future<HttpResponse<AutheticationResponse>> refreshToken (
    String tokenExpired,
  ) {
    
    return _http.request<AutheticationResponse>(
      '/api/auth/refreshtoken',
      method: 'POST',
      data: {"token":tokenExpired},
      parser: (data) {
        return AutheticationResponse.fromJson(data);
        
      },
      
    );
  }
}
