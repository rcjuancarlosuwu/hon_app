import 'dart:convert';

class SubjectOption {
  final String name;
  final String displayName;
  final String icon;
  final bool isSelected;

  const SubjectOption({
    required this.name,
    required this.displayName,
    required this.icon,
    this.isSelected = false,
  });

  SubjectOption copyWith({
    String? name,
    String? displayName,
    String? icon,
    bool? isSelected,
  }) {
    return SubjectOption(
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'displayName': displayName,
      'icon': icon,
      'isSelected': isSelected,
    };
  }

  factory SubjectOption.fromMap(Map<String, dynamic> map) {
    return SubjectOption(
      name: map['name'] ?? '',
      displayName: map['displayName'] ?? '',
      icon: map['icon'] ?? '',
      isSelected: map['isSelected'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectOption.fromJson(String source) =>
      SubjectOption.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubjectOption(name: $name, displayName: $displayName, icon: $icon, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubjectOption &&
        other.name == name &&
        other.displayName == displayName &&
        other.icon == icon &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        displayName.hashCode ^
        icon.hashCode ^
        isSelected.hashCode;
  }
}

const subjectsOptions = [
  SubjectOption(name: 'action', displayName: 'Acción', icon: '🔥'),
  SubjectOption(name: 'comedy', displayName: 'Comedia', icon: '😂'),
  SubjectOption(name: 'fantasy', displayName: 'Fantasia', icon: '🦄'),
  SubjectOption(name: 'horror', displayName: 'Horror', icon: '😱'),
  SubjectOption(name: 'criminal', displayName: 'Criminal', icon: '💀'),
  SubjectOption(name: 'romantic', displayName: 'Romance', icon: '🥰'),
];
