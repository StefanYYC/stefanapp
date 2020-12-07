import 'package:flutter/material.dart';
import 'package:stefanapp/models/generated_users/users.dart';

class UserDetailsPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String country;
  final String city;
  final String state;

  const UserDetailsPage(
      {Key key,
      @required this.firstName,
      @required this.lastName,
      @required this.country,
      @required this.city,
      @required this.state})
      : super(key: key);

  Route route(productId, type, title) {
    return MaterialPageRoute(
        builder: (_) => UserDetailsPage(
              firstName: firstName,
              city: city,
              country: country,
              lastName: lastName,
              state: state,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('$firstName'),
      ),
      backgroundColor: Colors.white,
      body: DetailsUser(),
    );
  }
}

class DetailsUser extends StatelessWidget {
  final Users user;
  const DetailsUser({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("${user.firstName}"),
    );
  }
}
