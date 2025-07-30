// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  title: json['title'] as String,
  description: json['description'] as String?,
  videoUrl: json['video_url'] as String?,
  coordinates: json['coordinates'] as String,
  grade: json['grade'] as String?,
  userId: json['user_id'] as String,
  climbTypeId: json['climb_type_id'] as String,
);

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'title': instance.title,
  'description': instance.description,
  'video_url': instance.videoUrl,
  'coordinates': instance.coordinates,
  'grade': instance.grade,
  'user_id': instance.userId,
  'climb_type_id': instance.climbTypeId,
};
