import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stefanapp/api/api_client.dart';
import 'package:stefanapp/models/generated_users/users.dart';
import 'package:stefanapp/user_details_page/bloc/bloc.dart';

class UserDetailsPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String country;
  final String city;
  final int id;

  const UserDetailsPage({
    Key key,
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.country,
    @required this.city,
  }) : super(key: key);

  static Route route({id, firstName, lastName, country, city}) {
    return MaterialPageRoute(
        builder: (_) => UserDetailsPage(
              id: id,
              firstName: firstName,
              city: city,
              country: country,
              lastName: lastName,
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
      body: BlocProvider(
        create: (context) => UserDetailsPageBloc(ApiClient())
          ..add(UserDetailsPageFetched(
              id: this.id,
              city: this.city,
              country: this.country,
              firstName: this.firstName,
              lastName: this.lastName)),
        child: DetailsUser(),
      ),
    );
  }
}

class DetailsUser extends StatefulWidget {
  @override
  _DetailsUserState createState() => _DetailsUserState();
}

class _DetailsUserState extends State<DetailsUser> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsPageBloc, UserDetailsPageState>(
      builder: (context, state) {
        if (state is UserDetailsPageLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserDetailsPageFailure) {
          return Center(
            child: Text('Impossible d\'afficher les détails'),
          );
        }
        if (state is UserDetailsPageSuccess) {
          return ContentUserDetails(user: state.user);
        }
        return Container();
      },
    );
  }
}

class ContentUserDetails extends StatelessWidget {
  final Users user;
  const ContentUserDetails({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(user.firstName),
    );
  }
}
