// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'climb_type.codegen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClimbType _$ClimbTypeFromJson(Map<String, dynamic> json) => ClimbType(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  name: json['name'] as String,
);

Map<String, dynamic> _$ClimbTypeToJson(ClimbType instance) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt.toIso8601String(),
  'name': instance.name,
};
