import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stefanapp/api/api_client.dart';
import 'package:stefanapp/authentication/authentication.dart';
import 'package:stefanapp/home/bloc/home.dart';
import 'package:stefanapp/models/generated_users/users.dart';
import 'package:stefanapp/user_details_page/user_details_page.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select(
      (AuthenticationBloc bloc) => bloc.state.user,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue ${user.username}'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(ApiClient())..add(HomeFetched()),
        child: ListUsers(),
      ),
    );
  }
}

class ListUsers extends StatefulWidget {
  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(builder: (context, state) {
      if (state is HomeInitial) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is HomeFailure) {
        return Center(
          child: Text('Impossible de charger les utilisateurs'),
        );
      }
      if (state is HomeSuccess) {
        if (state.users.isEmpty) {
          return Center(
            child: Text('Aucun utilisateur à afficher'),
          );
        }
      }
      return GridView.builder(
        itemBuilder: (BuildContext context, int index) {
          return index >= state.users.length
              ? BottomLoader()
              : UserWidget(user: state.users[index]);
        },
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
        ),
      );
    });
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            backgroundColor: Colors.orange,
          ),
        ),
      ),
    );
  }
}

class UserWidget extends StatelessWidget {
  final Users user;

  const UserWidget({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(UserDetailsPage.route(
        id: user.id,
        city: user.city,
        country: user.country,
        firstName: user.firstName,
        lastName: user.lastName,
      )),
      leading: Text('${user.email}'),
      title: Text('${user.lastName} ${user.firstName}'),
      isThreeLine: true,
      dense: true,
      subtitle: Text('${user.city}, ${user.country}'),
    );
  }
}
