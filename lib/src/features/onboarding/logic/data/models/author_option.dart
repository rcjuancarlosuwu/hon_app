import 'dart:convert';

class AuthorOption {
  final String olid;
  final String name;
  final int worksCount;
  final bool isSelected;

  const AuthorOption(
      {required this.olid,
      required this.name,
      required this.worksCount,
      this.isSelected = false});

  AuthorOption copyWith({
    String? olid,
    String? name,
    int? worksCount,
    bool? isSelected,
  }) {
    return AuthorOption(
      olid: olid ?? this.olid,
      name: name ?? this.name,
      worksCount: worksCount ?? this.worksCount,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'olid': olid,
      'name': name,
      'worksCount': worksCount,
      'isSelected': isSelected,
    };
  }

  factory AuthorOption.fromMap(Map<String, dynamic> map) {
    return AuthorOption(
      olid: map['olid'] ?? '',
      name: map['name'] ?? '',
      worksCount: map['worksCount']?.toInt() ?? 0,
      isSelected: map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorOption.fromJson(String source) =>
      AuthorOption.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthorOption(olid: $olid, name: $name, worksCount: $worksCount, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthorOption &&
        other.olid == olid &&
        other.name == name &&
        other.worksCount == worksCount &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return olid.hashCode ^
        name.hashCode ^
        worksCount.hashCode ^
        isSelected.hashCode;
  }
}
