import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:stefanapp/models/generated_users/users.dart';

class ApiClient {
  Response response;
  Dio dio = Dio();

  Future<List<Users>> fetchUsers(int limit) async {
    final response = await dio.get("https://randomuser.me/api/?results=$limit");

    if (response.statusCode == 200) {
      try {
        final body = json.decode(response.data) as Map;
        final data = body['results'] as List;
        return data.map((rawUser) {
          return Users(
            firstName: rawUser['name']['first'],
            lastName: rawUser['name']['last'],
            city: rawUser['location']['city'],
            country: rawUser['location']['country'],
            postalCode: rawUser['location']['postcode'],
            email: rawUser['email'],
            picture: rawUser['picture']['large'],
          );
        }).toList();
      } catch (_) {
        throw Exception();
      }
    } else {
      throw Exception('Erreur lors du chargement des résultats');
    }
  }
}
