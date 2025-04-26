// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
  id: (json['id'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  coordinates: json['coordinates'] as String,
  name: json['name'] as String,
  boulderCount: (json['boulder_count'] as num).toInt(),
  topRopeCount: (json['top_rope_count'] as num).toInt(),
  leadCount: (json['lead_count'] as num).toInt(),
  type: json['type'] as String,
);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'coordinates': instance.coordinates,
  'name': instance.name,
  'boulder_count': instance.boulderCount,
  'top_rope_count': instance.topRopeCount,
  'lead_count': instance.leadCount,
  'type': instance.type,
};
