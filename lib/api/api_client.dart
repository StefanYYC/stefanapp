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
        return response.data.map<Users>((rawUser) {
          // Fill in user model with data from API
          return Users(
            id: rawUser['id'] as int,
            firstName: rawUser['firstname'] as String,
            lastName: rawUser['lastname'] as String,
            city: rawUser['city'] as String,
            country: "France",
            postalCode: rawUser['postal'] as String,
            email: rawUser['email'] as String,
            picture: rawUser['image'] as String,
          );
        }).toList();
        // stack donne la ligne où l'erreur apparaît
      } catch (_, stack) {
        print(_);
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
        return response.data.map<Users>((rawUser) {
          return Users(
            description: rawUser['description'] as String,
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
