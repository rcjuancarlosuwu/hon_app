import 'dart:convert';

import 'package:flutter/foundation.dart';

class SearchAuthor {
  final String olid;
  final String name;
  final String? birthDate;
  final String? deathDate;
  final int worksCount;
  final List<String>? topSubjects;
  final String? topWork;

  SearchAuthor({
    required this.olid,
    required this.name,
    this.birthDate,
    this.deathDate,
    required this.worksCount,
    this.topSubjects,
    this.topWork,
  });

  SearchAuthor copyWith({
    String? olid,
    String? name,
    String? birthDate,
    String? deathDate,
    int? worksCount,
    List<String>? topSubjects,
    String? topWork,
  }) {
    return SearchAuthor(
      olid: olid ?? this.olid,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      deathDate: deathDate ?? this.deathDate,
      worksCount: worksCount ?? this.worksCount,
      topSubjects: topSubjects ?? this.topSubjects,
      topWork: topWork ?? this.topWork,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'olid': olid,
      'name': name,
      'birthDate': birthDate,
      'deathDate': deathDate,
      'worksCount': worksCount,
      'topSubjects': topSubjects,
      'topWork': topWork,
    };
  }

  factory SearchAuthor.fromMap(Map<String, dynamic> map) {
    return SearchAuthor(
      olid: map['olid'] ?? '',
      name: map['name'] ?? '',
      birthDate: map['birthDate'],
      deathDate: map['deathDate'],
      worksCount: map['worksCount']?.toInt() ?? 0,
      topSubjects: List<String>.from(map['topSubjects'] ?? []),
      topWork: map['topWork'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchAuthor.fromJson(String source) =>
      SearchAuthor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchAuthor(olid: $olid, name: $name, birthDate: $birthDate, deathDate: $deathDate, worksCount: $worksCount, topSubjects: $topSubjects, topWork: $topWork)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchAuthor &&
        other.olid == olid &&
        other.name == name &&
        other.birthDate == birthDate &&
        other.deathDate == deathDate &&
        other.worksCount == worksCount &&
        listEquals(other.topSubjects, topSubjects) &&
        other.topWork == topWork;
  }

  @override
  int get hashCode {
    return olid.hashCode ^
        name.hashCode ^
        birthDate.hashCode ^
        deathDate.hashCode ^
        worksCount.hashCode ^
        topSubjects.hashCode ^
        topWork.hashCode;
  }
}
