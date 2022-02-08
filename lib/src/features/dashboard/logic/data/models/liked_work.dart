import 'dart:convert';

class LikedWork {
  final int id;
  final String olid;
  final String title;
  final String? cover;
  final String description;
  final String createdAt;
  final String updatedAt;

  const LikedWork({
    required this.id,
    required this.olid,
    required this.title,
    this.cover,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  LikedWork copyWith({
    int? id,
    String? olid,
    String? title,
    String? cover,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) {
    return LikedWork(
      id: id ?? this.id,
      olid: olid ?? this.olid,
      title: title ?? this.title,
      cover: cover ?? this.cover,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'olid': olid,
      'title': title,
      'cover': cover,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory LikedWork.fromMap(Map<String, dynamic> map) {
    return LikedWork(
      id: map['id']?.toInt() ?? 0,
      olid: map['olid'] ?? '',
      title: map['title'] ?? '',
      cover: map['cover'].toString(),
      description: map['description'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LikedWork.fromJson(String source) =>
      LikedWork.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LikedWork(id: $id, olid: $olid, title: $title, cover: $cover, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LikedWork &&
        other.id == id &&
        other.olid == olid &&
        other.title == title &&
        other.cover == cover &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        olid.hashCode ^
        title.hashCode ^
        cover.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
