class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? imageUrl;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.imageUrl,
  });
}
