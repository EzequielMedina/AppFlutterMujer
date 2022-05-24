import 'package:appcuidatemujer/data/authetication_client.dart';
import 'package:appcuidatemujer/helpers/http.dart';
import 'package:appcuidatemujer/helpers/http_response.dart';
import 'package:appcuidatemujer/models/user.dart';

class AccountApi {
  final Http _http;
  final AutheticationClient _autheticationClient;

  AccountApi(this._http, this._autheticationClient);

  Future<HttpResponse<User>> getUserInfo() async {
    final token = await _autheticationClient.accessToken;
    return _http.request<User>(
      "/api/auth/private",
      method: 'GET',
      headers: {
        "Authorization": "Bearer " + token!,
      },
      parser: (data) {
        return User.fromJson(data);
      },
    );
  }
}
