import 'package:appcuidatemujer/api/account_api.dart';
import 'package:appcuidatemujer/api/authentication_api.dart';
import 'package:appcuidatemujer/data/authetication_client.dart';
import 'package:appcuidatemujer/helpers/http.dart';
import 'package:appcuidatemujer/utils/socket_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static void initialize() {
    final Dio dio = Dio(BaseOptions(
      baseUrl: "http://192.168.100.4:5001",
      
    ),);
    Http http = Http(
      dio: dio,
      logsEnabled: true,
    );
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();

    final AuthenticationApi autenticationApi = AuthenticationApi(http);
    final AutheticationClient autheticationClient = AutheticationClient(secureStorage, autenticationApi);
    final AccountApi accountApi = AccountApi(http, autheticationClient);

    GetIt.instance.registerSingleton<AuthenticationApi>(autenticationApi);
    GetIt.instance.registerSingleton<AutheticationClient>(autheticationClient);
    GetIt.instance.registerSingleton<AccountApi>(accountApi);
    

  }
}
