import 'dart:convert';

class SearchEdition {
  final String olid;
  final String title;
  final String isbn10;
  final String? isbn13;
  final int revisions;
  final String publisher;
  final String? contributer;

  SearchEdition({
    required this.olid,
    required this.title,
    required this.isbn10,
    this.isbn13,
    required this.revisions,
    required this.publisher,
    this.contributer,
  });

  SearchEdition copyWith({
    String? olid,
    String? title,
    String? isbn10,
    String? isbn13,
    int? revisions,
    String? publisher,
    String? contributer,
  }) {
    return SearchEdition(
      olid: olid ?? this.olid,
      title: title ?? this.title,
      isbn10: isbn10 ?? this.isbn10,
      isbn13: isbn13 ?? this.isbn13,
      revisions: revisions ?? this.revisions,
      publisher: publisher ?? this.publisher,
      contributer: contributer ?? this.contributer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'olid': olid,
      'title': title,
      'isbn10': isbn10,
      'isbn13': isbn13,
      'revisions': revisions,
      'publisher': publisher,
      'contributer': contributer,
    };
  }

  factory SearchEdition.fromMap(Map<String, dynamic> map) {
    return SearchEdition(
      olid: map['olid'] ?? '',
      title: map['title'] ?? '',
      isbn10: map['isbn10'] ?? '',
      isbn13: map['isbn13'],
      revisions: map['revisions']?.toInt() ?? 0,
      publisher: map['publisher'] ?? '',
      contributer: map['contributer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchEdition.fromJson(String source) =>
      SearchEdition.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchEdition(olid: $olid, title: $title, isbn10: $isbn10, isbn13: $isbn13, revisions: $revisions, publisher: $publisher, contributer: $contributer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchEdition &&
        other.olid == olid &&
        other.title == title &&
        other.isbn10 == isbn10 &&
        other.isbn13 == isbn13 &&
        other.revisions == revisions &&
        other.publisher == publisher &&
        other.contributer == contributer;
  }

  @override
  int get hashCode {
    return olid.hashCode ^
        title.hashCode ^
        isbn10.hashCode ^
        isbn13.hashCode ^
        revisions.hashCode ^
        publisher.hashCode ^
        contributer.hashCode;
  }
}
