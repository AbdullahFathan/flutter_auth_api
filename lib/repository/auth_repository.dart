import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_api/repository/cache_repository.dart';

class AuthRepository {
  String baseUrl = "https://reqres.in";
  var client = http.Client();

  // If user success login, write token from server into local storage and give return true

  Future loginServices(String email, String password) async {
    var uri = Uri.parse('$baseUrl/api/login');
    try {
      var response = await http.post(uri,
          body: jsonEncode({
            "email": email,
            "password": password,
          }));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        await Cache.writeData(key: 'token_user', value: data['token']);
        print("Login success [auth_repository.dart]");

        return true;
      } else {
        var data = jsonDecode(response.body);

        print(
            "Login Invalid  and status code = ${response.statusCode} [auth_repository.dart]");
        print(" form server =  ${data['error']}  ##[auth_repository.dart]");
      }
    } catch (eror) {
      print("Eror at LoginServices [auth_repository.dart]: ${eror.toString()}");
    }
    return false;
  }
}
