import 'dart:convert';

import 'package:clients/models/user.dart';
import 'package:clients/utils/utils.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<LoginResponse> login(String username, String password) async {
    try {

      final response = await http.post(
          Uri.parse('${AppSize.endpoint}/login'),
          headers: <String, String> {
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(<String, String>{
            "username" : username,
            "password" : password
          })
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load categories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}