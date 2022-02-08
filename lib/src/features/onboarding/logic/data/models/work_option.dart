import 'dart:convert';

class WorkOption {
  final String olid;
  final String title;
  final int? cover;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final bool isSelected;

  const WorkOption({
    required this.olid,
    required this.title,
    this.cover,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.isSelected = false,
  });

  WorkOption copyWith({
    String? olid,
    String? title,
    int? cover,
    String? description,
    String? createdAt,
    String? updatedAt,
    bool? isSelected,
  }) {
    return WorkOption(
      olid: olid ?? this.olid,
      title: title ?? this.title,
      cover: cover ?? this.cover,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'olid': olid,
      'title': title,
      'cover': cover,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isSelected': isSelected,
    };
  }

  factory WorkOption.fromMap(Map<String, dynamic> map) {
    return WorkOption(
      olid: map['olid'] ?? '',
      title: map['title'] ?? '',
      cover: map['cover']?.toInt(),
      description: map['description'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      isSelected: map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkOption.fromJson(String source) =>
      WorkOption.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WorkOption(olid: $olid, title: $title, cover: $cover, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WorkOption &&
        other.olid == olid &&
        other.title == title &&
        other.cover == cover &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return olid.hashCode ^
        title.hashCode ^
        cover.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        isSelected.hashCode;
  }
}
