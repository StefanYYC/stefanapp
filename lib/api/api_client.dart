import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:stefanapp/models/generated_users/users.dart';

class ApiClient {
  Response response;
  Dio dio = Dio();

  Future<List<Users>> fetchUsers() async {
    // Custom API
    final response = await dio
        .get("https://my-json-server.typicode.com/stefanyyc/demo/users");

    if (response.statusCode == 200) {
      try {
        final body = json.decode(response.data) as Map;
        final data = body['users'] as List;
        return data.map((rawUser) {
          // Fill in user model with data from API
          return Users(
            id: rawUser['id'],
            firstName: rawUser['firstname'],
            lastName: rawUser['lastname'],
            city: rawUser['city'],
            country: "France",
            postalCode: rawUser['postal'],
            email: rawUser['email'],
            picture: rawUser['image'],
          );
        }).toList();
      } catch (_) {
        throw Exception();
      }
    } else {
      throw Exception('Erreur lors du chargement des résultats');
    }
  }

  Future<Users> fetchUsersDetail(int id) async {
    final response = await dio
        .get("https://my-json-server.typicode.com/stefanyyc/demo/users?id=$id");

    if (response.statusCode == 200) {
      try {
        final body = json.decode(response.data) as Map;
        final data = body['users'];
        return data.map((rawUser) {
          return Users(
            description: rawUser['description'],
          );
        }).toList();
      } catch (_) {
        throw Exception();
      }
    } else {
      throw Exception("Impossible de récupérer les détails.");
    }
  }
}
