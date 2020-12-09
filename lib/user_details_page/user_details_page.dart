import 'package:flutter/cupertino.dart';
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
  final String description;
  final String image;
  final String email;

  const UserDetailsPage({
    Key key,
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.country,
    @required this.city,
    @required this.description,
    @required this.image,
    @required this.email,
  }) : super(key: key);

  static Route route(
      {id, firstName, lastName, country, city, image, description, email}) {
    return MaterialPageRoute(
        builder: (_) => UserDetailsPage(
              id: id,
              firstName: firstName,
              city: city,
              country: country,
              lastName: lastName,
              image: image,
              description: description,
              email: email,
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
        body:
            /* BlocProvider(
        create: (context) => UserDetailsPageBloc(ApiClient())
          ..add(UserDetailsPageFetched(
              id: this.id,)),
        child: DetailsUser(),
      ),*/
            Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              animationImage(),
              SizedBox(
                height: 15,
              ),
              cardWidget()
            ],
          ),
        ));
  }

  Widget animationImage() {
    return Center(
        child: Hero(
      tag: 'avatar_' + id.toString(),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: Image(image: NetworkImage(image))),
    ));
  }

  Widget cardWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Card(
            elevation: 8,
            shadowColor: Colors.grey,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                      text: "$firstName $lastName ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.blueAccent),
                      children: <TextSpan>[
                        TextSpan(
                            text: "habite en $country dans la ville de $city.")
                      ]),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '" $description "',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                  ),
                ),
                emailWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget emailWidget() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, top: 25.0, bottom: 15.0),
        child: Text(
          email,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

/* class DetailsUser extends StatefulWidget {
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
 */
