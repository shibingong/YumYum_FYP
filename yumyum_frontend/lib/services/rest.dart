import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RestService {
  final storage = const FlutterSecureStorage();
  final String _baseUrl;
  const RestService({@required baseUrl}) : _baseUrl = baseUrl;

  // Send a GET request to retrieve data from a REST server
  Future get(String endpoint) async {
    String jwt = await storage.read(key: 'jwt');
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Authorization': 'Bearer $jwt'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  // Send a POST request to add a new in the REST server
  Future post(String endpoint, {dynamic data}) async {
    print(data);
    String jwt = await storage.read(key: 'jwt');
    final response = await http.post(Uri.parse('$_baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  // Send a PUT request to update an existing data in the REST server.
  Future put(String endpoint, {dynamic data}) async {
    String jwt = await storage.read(key: 'jwt');
    final response = await http.put(Uri.parse('$_baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  // Send a PATCH request to update parts of an existing data in the REST server.
  Future patch(String endpoint, {dynamic data}) async {
    String jwt = await storage.read(key: 'jwt');
    final response = await http.patch(Uri.parse('$_baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt'
        },
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  // Send a DELETE request to remove an existing data from the REST server.
  Future delete(String endpoint) async {
    String jwt = await storage.read(key: 'jwt');
    final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Authorization': 'Bearer $jwt'});

    if (response.statusCode == 200) {
      return;
    }
    throw response;
  }

  Future getNutri(String endpoint) async {
    final response = await http.get(
        Uri.parse('https://api.calorieninjas.com/v1/nutrition?query=$endpoint'),
        headers: {'X-Api-Key': 'H3FrI8uzSswzX2DWzjk6ow==4JsO3FwsJaQXsk7S'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }
}
