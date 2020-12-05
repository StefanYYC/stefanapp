import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  const User({this.id, @required this.username});

  final String id;
  final String username;

  @override
  List<Object> get props => [id, username];

  static const empty = User(id: "", username: "");
}
