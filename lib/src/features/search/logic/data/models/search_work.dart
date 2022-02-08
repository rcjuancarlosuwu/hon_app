import 'dart:convert';

import 'package:flutter/foundation.dart';

class SearchWork {
  final String olid;
  final String title;
  final int? numOfPages;
  final int? cover;
  final List<String>? firstSentences;
  final List<String> author;
  final String authorOlid;
  final int firstPublishYear;
  final List<String> editions;

  SearchWork({
    required this.olid,
    required this.title,
    this.numOfPages,
    this.cover,
    this.firstSentences,
    required this.author,
    required this.authorOlid,
    required this.firstPublishYear,
    required this.editions,
  });

  SearchWork copyWith({
    String? olid,
    String? title,
    int? numOfPages,
    int? cover,
    List<String>? firstSentences,
    List<String>? author,
    String? authorOlid,
    int? firstPublishYear,
    List<String>? editions,
  }) {
    return SearchWork(
      olid: olid ?? this.olid,
      title: title ?? this.title,
      numOfPages: numOfPages ?? this.numOfPages,
      cover: cover ?? this.cover,
      firstSentences: firstSentences ?? this.firstSentences,
      author: author ?? this.author,
      authorOlid: authorOlid ?? this.authorOlid,
      firstPublishYear: firstPublishYear ?? this.firstPublishYear,
      editions: editions ?? this.editions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'olid': olid,
      'title': title,
      'numOfPages': numOfPages,
      'cover': cover,
      'firstSentences': firstSentences,
      'author': author,
      'authorOlid': authorOlid,
      'firstPublishYear': firstPublishYear,
      'editions': editions,
    };
  }

  factory SearchWork.fromMap(Map<String, dynamic> map) {
    return SearchWork(
      olid: map['olid'] ?? '',
      title: map['title'] ?? '',
      numOfPages: map['numOfPages']?.toInt(),
      cover: map['cover']?.toInt(),
      firstSentences: List<String>.from(map['firstSentences'] ?? []),
      author: List<String>.from(map['author']),
      authorOlid: map['authorOlid'] ?? '',
      firstPublishYear: map['firstPublishYear']?.toInt() ?? 0,
      editions: List<String>.from(map['editions']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchWork.fromJson(String source) =>
      SearchWork.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchWork(olid: $olid, title: $title, numOfPages: $numOfPages, cover: $cover, firstSentences: $firstSentences, author: $author, authorOlid: $authorOlid, firstPublishYear: $firstPublishYear, editions: $editions)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchWork &&
        other.olid == olid &&
        other.title == title &&
        other.numOfPages == numOfPages &&
        other.cover == cover &&
        listEquals(other.firstSentences, firstSentences) &&
        listEquals(other.author, author) &&
        other.authorOlid == authorOlid &&
        other.firstPublishYear == firstPublishYear &&
        listEquals(other.editions, editions);
  }

  @override
  int get hashCode {
    return olid.hashCode ^
        title.hashCode ^
        numOfPages.hashCode ^
        cover.hashCode ^
        firstSentences.hashCode ^
        author.hashCode ^
        authorOlid.hashCode ^
        firstPublishYear.hashCode ^
        editions.hashCode;
  }
}
