import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stefanapp/login/login.dart';
import 'package:flutter/material.dart';
import 'package:stefanapp/login/ui/login_form.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 200),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoClipped(),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

// Transforme l'image en triangle
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}

class LogoClipped extends StatelessWidget {
  const LogoClipped({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: TriangleClipper(),
        child: Image.asset("assets/img/bird.png"));
  }
}
