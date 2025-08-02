import 'package:json_annotation/json_annotation.dart';

part 'post.codegen.g.dart';

@JsonSerializable()
class Post {
  final String? id;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  final String title;
  final String? description;

  @JsonKey(name: 'video_url')
  final String? videoUrl;

  final String? coordinates;

  final String? grade;

  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'climb_type_id')
  final String climbTypeId;

  Post({
    this.id,
    this.createdAt,
    required this.title,
    this.description,
    this.videoUrl,
    this.coordinates,
    this.grade,
    this.userId,
    required this.climbTypeId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
