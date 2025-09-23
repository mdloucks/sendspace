// Base sealed class
sealed class ClimbingGrade {
  final String name;

  const ClimbingGrade({required this.name});
  int get rank;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is ClimbingGrade && rank == other.rank;
  }

  @override
  int get hashCode => Object.hash(runtimeType, rank);

  bool operator <(ClimbingGrade other) {
    _assertSameSystem(other);
    return rank < other.rank;
  }

  bool operator >(ClimbingGrade other) {
    _assertSameSystem(other);
    return rank > other.rank;
  }

  bool operator <=(ClimbingGrade other) {
    _assertSameSystem(other);
    return rank <= other.rank;
  }

  bool operator >=(ClimbingGrade other) {
    _assertSameSystem(other);
    return rank >= other.rank;
  }

  void _assertSameSystem(ClimbingGrade other) {
    if (runtimeType != other.runtimeType) {
      throw ArgumentError(
        "Cannot compare grades from different systems: "
        "$runtimeType vs ${other.runtimeType}",
      );
    }
  }
}

// ------------------- V-Grade (Bouldering) -------------------
class VGrade extends ClimbingGrade {
  static const List<String> _grades = [
    "VB",
    "V0",
    "V1",
    "V2",
    "V3",
    "V4",
    "V5",
    "V6",
    "V7",
    "V8",
    "V9",
    "V10",
    "V11",
    "V12",
    "V13",
    "V14",
    "V15",
    "V16",
    "V17",
  ];

  const VGrade({required super.name}) : super();

  @override
  int get rank {
    final idx = _grades.indexOf(name.toUpperCase());
    if (idx == -1) {
      throw ArgumentError("Unknown VGrade: $name");
    }
    return idx;
  }
}

// ------------------- Yosemite Decimal (Sport/Trad) -------------------
class YosemiteGrade extends ClimbingGrade {
  static const List<String> _grades = [
    "5.0",
    "5.1",
    "5.2",
    "5.3",
    "5.4",
    "5.5",
    "5.6",
    "5.7",
    "5.8",
    "5.9",
    "5.10a",
    "5.10b",
    "5.10c",
    "5.10d",
    "5.11a",
    "5.11b",
    "5.11c",
    "5.11d",
    "5.12a",
    "5.12b",
    "5.12c",
    "5.12d",
    "5.13a",
    "5.13b",
    "5.13c",
    "5.13d",
    "5.14a",
    "5.14b",
    "5.14c",
    "5.14d",
    "5.15a",
    "5.15b",
    "5.15c",
    "5.15d",
  ];

  const YosemiteGrade({required super.name}) : super();

  @override
  int get rank {
    final idx = _grades.indexOf(name.toLowerCase());
    if (idx == -1) {
      throw ArgumentError("Unknown YosemiteGrade: $name");
    }
    return idx;
  }
}

// ------------------- French Grades -------------------
class FrenchGrade extends ClimbingGrade {
  static const List<String> _grades = [
    "3",
    "4a",
    "4b",
    "4c",
    "5a",
    "5b",
    "5c",
    "6a",
    "6a+",
    "6b",
    "6b+",
    "6c",
    "6c+",
    "7a",
    "7a+",
    "7b",
    "7b+",
    "7c",
    "7c+",
    "8a",
    "8a+",
    "8b",
    "8b+",
    "8c",
    "8c+",
    "9a",
    "9a+",
    "9b",
    "9b+",
    "9c",
  ];

  const FrenchGrade({required super.name}) : super();

  @override
  int get rank {
    final idx = _grades.indexOf(name.toLowerCase());
    if (idx == -1) {
      throw ArgumentError("Unknown FrenchGrade: $name");
    }
    return idx;
  }
}
