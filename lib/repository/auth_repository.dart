import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_api/models/register.dart';
import 'package:login_api/repository/cache_repository.dart';

class AuthRepository {
  String baseUrl = "https://reqres.in";
  var client = http.Client();

  // If user success login, write token from server into local storage and give return true

  Future loginServices(String email, String password) async {
    var uri = Uri.parse('$baseUrl/api/login');
    try {
      var response = await client.post(uri,
          headers: {"content-type": "application/json"},
          body: json.encode({
            "email": email,
            "password": password,
          }));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        await Cache.writeData(key: 'user_token', value: data['token']);
        await Cache.writeData(key: 'user_email', value: email);
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

  Future logoutServices() async {
    await Cache.deleteData('user_data');
  }

  Future registerServices(String email, String password) async {
    var uri = Uri.parse("$baseUrl/api/register");
    try {
      var response = await client.post(uri,
          headers: {"content-type": "application/json"},
          body: json.encode({
            'email': email,
            'password': password,
          }));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        await Cache.writeData(key: 'user_token', value: data['token']);
        await Cache.writeData(key: 'user_email', value: email);

        print('Register success [auth_repository.dart]');
        return RegisterModel(id: data['id'], token: data['token']);
      } else {
        var data = jsonDecode(response.body);

        print(
            "Register Invalid  and status code = ${response.statusCode} [auth_repository.dart]");
        print(" form server =  ${data['error']}  ##[auth_repository.dart]");
      }
    } catch (eror) {
      print(
          "Eror at RegisterServices [auth_repository.dart]: ${eror.toString()}");
    }
    return null;
  }
}
