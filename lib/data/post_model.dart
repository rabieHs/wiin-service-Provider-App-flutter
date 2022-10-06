// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Post {
  final String name;
  final String userId;
  final String time;
  final String description;
  final String image;

  Post(
      {required this.name,
      required this.userId,
      required this.time,
      required this.description,
      required this.image});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userId': userId,
      'time': time,
      'description': description,
      'image': image,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      name: map['name'] as String,
      userId: map['userId'] as String,
      time: map['time'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
