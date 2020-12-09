part of 'user_details_page_bloc.dart';

abstract class UserDetailsPageEvent extends Equatable {
  const UserDetailsPageEvent();

  @override
  List<Object> get props => [];
}

class UserDetailsPageFetched extends UserDetailsPageEvent {
  final int id;

  UserDetailsPageFetched({this.id});
  @override
  List<Object> get props => [id];
}
