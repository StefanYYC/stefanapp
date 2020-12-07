import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stefanapp/authentication/authentication.dart';
import 'package:stefanapp/home/bloc/home.dart';
import 'package:stefanapp/models/generated_users/users.dart';

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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset("assets/img/bird.png"),
        ],
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
        ),
        itemBuilder: (BuildContext context, int index) {},
      );
    });
  }
}

class UserWidget extends StatelessWidget {
  final Users user;

  const UserWidget({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext contextn) {
    return ListTile(
      onTap: () => {},
      leading: Text('${user.email}'),
      title: Text('${user.lastName} ${user.firstName}'),
      isThreeLine: true,
      dense: true,
      subtitle: Text('${user.city}, ${user.country}'),
    );
  }
}
