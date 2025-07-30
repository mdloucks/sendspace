import 'package:json_annotation/json_annotation.dart';

part 'post.codegen.g.dart';

@JsonSerializable()
class Post {
  final String id;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  final String title;
  final String? description;

  @JsonKey(name: 'video_url')
  final String? videoUrl;

  final String coordinates;

  final String? grade;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'climb_type_id')
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

//CREATE TABLE IF NOT EXISTS "public"."posts" (
//    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
//    "created_at" timestamp with time zone DEFAULT "now"(),
//    "title" "text" NOT NULL,
//    "description" "text",
//    "video_url" "text",
//    "coordinates" "tiger"."geography" NOT NULL,
//    "grade" character varying(10),
//    "user_id" "uuid",
//    "climb_type_id" "uuid"
//);
