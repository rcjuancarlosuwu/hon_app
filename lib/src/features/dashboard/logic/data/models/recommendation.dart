import 'dart:convert';

import 'package:flutter/foundation.dart';

class Recommendation {
  final String type;
  final Map<String, Object?> recomendation;
  Recommendation({
    required this.type,
    required this.recomendation,
  });

  Recommendation copyWith({
    String? type,
    Map<String, Object?>? recomendation,
  }) {
    return Recommendation(
      type: type ?? this.type,
      recomendation: recomendation ?? this.recomendation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'recomendation': recomendation,
    };
  }

  factory Recommendation.fromMap(Map<String, dynamic> map) {
    return Recommendation(
      type: map['type'] ?? '',
      recomendation: Map<String, Object?>.from(map['recomendation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recommendation.fromJson(String source) =>
      Recommendation.fromMap(json.decode(source));

  @override
  String toString() =>
      'Recommendation(type: $type, recomendation: $recomendation)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Recommendation &&
        other.type == type &&
        mapEquals(other.recomendation, recomendation);
  }

  @override
  int get hashCode => type.hashCode ^ recomendation.hashCode;
}
