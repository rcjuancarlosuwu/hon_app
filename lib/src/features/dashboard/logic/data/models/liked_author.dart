import 'dart:convert';

class LikedAuthor {
  final int id;
  final String olid;
  final String name;
  final String? title;
  final String? personalName;
  final String? deathDate;
  final String? birthDate;
  final String? bio;
  final String? wikipedia;
  final String? bookBrainz;
  final String? inventaire;
  final String? createdAt;
  final String? updatedAt;

  const LikedAuthor({
    required this.id,
    required this.olid,
    required this.name,
    this.title,
    this.personalName,
    this.deathDate,
    this.birthDate,
    this.bio,
    this.wikipedia,
    this.bookBrainz,
    this.inventaire,
    this.createdAt,
    this.updatedAt,
  });

  LikedAuthor copyWith({
    int? id,
    String? olid,
    String? name,
    String? title,
    String? personalName,
    String? deathDate,
    String? birthDate,
    String? bio,
    String? wikipedia,
    String? bookBrainz,
    String? inventaire,
    String? createdAt,
    String? updatedAt,
  }) {
    return LikedAuthor(
      id: id ?? this.id,
      olid: olid ?? this.olid,
      name: name ?? this.name,
      title: title ?? this.title,
      personalName: personalName ?? this.personalName,
      deathDate: deathDate ?? this.deathDate,
      birthDate: birthDate ?? this.birthDate,
      bio: bio ?? this.bio,
      wikipedia: wikipedia ?? this.wikipedia,
      bookBrainz: bookBrainz ?? this.bookBrainz,
      inventaire: inventaire ?? this.inventaire,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'olid': olid,
      'name': name,
      'title': title,
      'personalName': personalName,
      'deathDate': deathDate,
      'birthDate': birthDate,
      'bio': bio,
      'wikipedia': wikipedia,
      'bookBrainz': bookBrainz,
      'inventaire': inventaire,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory LikedAuthor.fromMap(Map<String, dynamic> map) {
    return LikedAuthor(
      id: map['id']?.toInt() ?? 0,
      olid: map['olid'] ?? '',
      name: map['name'] ?? '',
      title: map['title'],
      personalName: map['personalName'],
      deathDate: map['deathDate'],
      birthDate: map['birthDate'],
      bio: map['bio'],
      wikipedia: map['wikipedia'],
      bookBrainz: map['bookBrainz'],
      inventaire: map['inventaire'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LikedAuthor.fromJson(String source) =>
      LikedAuthor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LikedAuthor(id: $id, olid: $olid, name: $name, title: $title, personalName: $personalName, deathDate: $deathDate, birthDate: $birthDate, bio: $bio, wikipedia: $wikipedia, bookBrainz: $bookBrainz, inventaire: $inventaire, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LikedAuthor &&
        other.id == id &&
        other.olid == olid &&
        other.name == name &&
        other.title == title &&
        other.personalName == personalName &&
        other.deathDate == deathDate &&
        other.birthDate == birthDate &&
        other.bio == bio &&
        other.wikipedia == wikipedia &&
        other.bookBrainz == bookBrainz &&
        other.inventaire == inventaire &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        olid.hashCode ^
        name.hashCode ^
        title.hashCode ^
        personalName.hashCode ^
        deathDate.hashCode ^
        birthDate.hashCode ^
        bio.hashCode ^
        wikipedia.hashCode ^
        bookBrainz.hashCode ^
        inventaire.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
