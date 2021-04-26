import 'dart:convert';
import 'package:example_app/models/user.dart';
import 'package:http/http.dart' as http;

Future<User> fetchUser() async {
  final response = await http.post(
      Uri.http('3.7.71.29:6001', '/get_user_details'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'mobile': '1234567890'}));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}
