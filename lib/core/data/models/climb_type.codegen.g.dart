// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'climb_type.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClimbType _$ClimbTypeFromJson(Map<String, dynamic> json) => ClimbType(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  name: json['name'] as String,
);

Map<String, dynamic> _$ClimbTypeToJson(ClimbType instance) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'name': instance.name,
};
