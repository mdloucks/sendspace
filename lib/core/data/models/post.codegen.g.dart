// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  title: json['title'] as String,
  description: json['description'] as String?,
  videoUrl: json['videoUrl'] as String?,
  coordinates: json['coordinates'] as String,
  grade: json['grade'] as String?,
  userId: json['userId'] as String,
  climbTypeId: json['climbTypeId'] as String,
);

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
  'title': instance.title,
  'description': instance.description,
  'videoUrl': instance.videoUrl,
  'coordinates': instance.coordinates,
  'grade': instance.grade,
  'userId': instance.userId,
  'climbTypeId': instance.climbTypeId,
};
