import 'dart:convert';

import 'package:flutter_delivery_app/domain/entities/user/user.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

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
    id: json['_id'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    password: json['password'],
    imageUrl: json['imageUrl'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'password': password,
    'imageUrl': imageUrl,
  };
}
