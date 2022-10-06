// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WorksModel {
  final String title;
  final String content;
  final List<String> images;
  final String userId;

  WorksModel({
    required this.images,
    required this.title,
    required this.content,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'images': images,
      'userId': userId,
    };
  }

  factory WorksModel.fromMap(Map<String, dynamic> map) {
    return WorksModel(
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      images: List<String>.from(map['images']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorksModel.fromJson(String source) =>
      WorksModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
