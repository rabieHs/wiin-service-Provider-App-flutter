// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String password;
  final String type;
  final String phone;
  final String id;
  final String token;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.phone,
    required this.id,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'phone': phone,
      'id': id,
      'token': token
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['_id'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
        password: map['password'] as String,
        type: map['type'] as String,
        phone: map['phone'] as String,
        token: map['token'] as String);
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? type,
    String? phone,
    String? id,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      phone: phone ?? this.phone,
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }
}
