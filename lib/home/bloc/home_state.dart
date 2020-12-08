part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFailure extends HomeState {}

class HomeSuccess extends HomeState {

  final List<Users> users;

  const HomeSuccess({this.users});

  HomeSuccess copyWith({
    List<Users> users,
  }) {
    return HomeSuccess(
      users: users ?? this.users,
    );
  }

  @override
  List<Object> get props => [users];

  @override
  String toString() => 'HomeSuccess ${users.length}';
}
