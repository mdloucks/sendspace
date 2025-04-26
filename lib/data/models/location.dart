import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int id;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  final String coordinates;

  final String name;

  @JsonKey(name: 'boulder_count')
  final int boulderCount;

  @JsonKey(name: 'top_rope_count')
  final int topRopeCount;

  @JsonKey(name: 'lead_count')
  final int leadCount;

  final String type;

  Location({
    required this.id,
    required this.createdAt,
    required this.coordinates,
    required this.name,
    required this.boulderCount,
    required this.topRopeCount,
    required this.leadCount,
    required this.type,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
