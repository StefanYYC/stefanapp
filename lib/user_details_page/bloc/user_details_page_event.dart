part of 'user_details_page_bloc.dart';

abstract class UserDetailsPageEvent extends Equatable {
  const UserDetailsPageEvent();

  @override
  List<Object> get props => [];
}

class UserDetailsPageFetched extends UserDetailsPageEvent {
  final int id;
  final String city;
  final String firstName;
  final String lastName;
  final String country;

  UserDetailsPageFetched({this.city, this.firstName, this.lastName, this.country, this.id});
  @override
  List<Object> get props => [id, city, firstName, lastName, country];
}
