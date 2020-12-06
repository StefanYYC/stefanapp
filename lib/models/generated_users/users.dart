class Users {
  final String firstName;
  final String lastName;
  final String email;
  final String city;
  final String picture;
  final String country;
  final int postalCode;

  Users(
      {this.firstName,
      this.lastName,
      this.email,
      this.city,
      this.picture,
      this.country,
      this.postalCode});

  List<Object> get props =>
      [firstName, lastName, email, city, picture, country, postalCode];

  bool get isEmpty => firstName.isNotEmpty;

  @override
  String toString() => 'First name { firstname: $firstName }';
}
