import 'package:json_annotation/json_annotation.dart';

part 'post.codegen.g.dart';

@JsonSerializable()
class Post {
  final String id;
  final DateTime createdAt;
  final String title;
  final String? description;
  final String? videoUrl;

  final String coordinates;

  final String? grade;
  final String userId;
  final String climbTypeId;

  Post({
    required this.id,
    required this.createdAt,
    required this.title,
    this.description,
    this.videoUrl,
    required this.coordinates,
    this.grade,
    required this.userId,
    required this.climbTypeId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
