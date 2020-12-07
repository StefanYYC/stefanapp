class Users {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String city;
  final String picture;
  final String country;
  final String postalCode;
  final String image;
  final String description;

  Users(
      {this.image,
      this.description,
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.city,
      this.picture,
      this.country,
      this.postalCode});

  List<Object> get props => [
        id,
        firstName,
        lastName,
        email,
        city,
        picture,
        country,
        postalCode,
        image,
        description,
      ];

  bool get isEmpty => firstName.isNotEmpty;

  @override
  String toString() => 'First name { firstname: $firstName }';
}
