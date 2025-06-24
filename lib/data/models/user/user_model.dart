import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends User {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String firstName;

  @HiveField(2)
  @override
  final String lastName;

  @HiveField(3)
  @override
  final String email;

  @HiveField(4)
  @override
  final String password;

  @HiveField(5)
  @override
  final String? imageUrl;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.imageUrl,
  }) : super(
         id: id,
         firstName: firstName,
         lastName: lastName,
         email: email,
         password: password,
         imageUrl: imageUrl,
       );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    password: json['password'],
    imageUrl: json['image_url'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'password': password,
    'image_url': imageUrl,
  };
}
