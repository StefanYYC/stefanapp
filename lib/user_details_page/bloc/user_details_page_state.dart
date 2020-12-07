part of 'user_details_page_bloc.dart';

abstract class UserDetailsPageState extends Equatable {
  const UserDetailsPageState();

  @override
  List<Object> get props => [];
}

class UserDetailsPageInitial extends UserDetailsPageState {}

class UserDetailsPageLoading extends UserDetailsPageState {}

class UserDetailsPageFailure extends UserDetailsPageState {}

class UserDetailsPageSuccess extends UserDetailsPageState {
  final Users user;

  UserDetailsPageSuccess({this.user});

  UserDetailsPageSuccess copyWith({
    List<Users> user,
  }) {
    return UserDetailsPageSuccess(user: user ?? this.user);
  }

  @override
  List<Object> get props => [user];
}
