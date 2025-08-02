import 'package:json_annotation/json_annotation.dart';

part 'climb_type.codegen.g.dart';

@JsonSerializable()
class ClimbType {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'name')
  final String name;

  ClimbType({required this.id, required this.createdAt, required this.name});

  factory ClimbType.fromJson(Map<String, dynamic> json) =>
      _$ClimbTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ClimbTypeToJson(this);
}
