import 'dart:convert';
import 'dart:math';

import 'package:appcuidatemujer/models/authetication_response.dart';
import 'package:appcuidatemujer/models/session.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../api/authentication_api.dart';

class AutheticationClient {
  final FlutterSecureStorage _secureStorage;
  final AuthenticationApi _autheticationApi;
  AutheticationClient(this._secureStorage, this._autheticationApi);

  Future<String?> get accessToken async {
    final data = await _secureStorage.read(key: 'SESSION');
    if (data != null) {
      final session = Session.fromJson(jsonDecode(data));
      final DateTime currentDate = DateTime.now();
      final DateTime createAt = session.createAt;
      final int expiresIn = 3600;

      final int diff = currentDate.difference(createAt).inSeconds;

      print("session life time: ${expiresIn - diff}");
      if(expiresIn - diff >= 350){        
        return session.token;
      }
      final response = await _autheticationApi.refreshToken(session.token);
      if( response.data != null){
        await saveSession(response.data!);
        return response.data?.token;
      }
      return null;
    }
    return null;
  }

  Future<void> saveSession(AutheticationResponse autheticationResponse) async {
    final Session session = Session(
      token: autheticationResponse.token,
      createAt: DateTime.now(),
    );

    final data = jsonEncode(session.toJson());

    await _secureStorage.write(key: 'SESSION', value: data);
  }

  Future<void> singOut() async {
    await _secureStorage.deleteAll();
  }
}
