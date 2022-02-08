import 'dart:convert';

class AuthUser {
  final String uid;
  final String email;
  final String name;
  final String photoURL;

  AuthUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.photoURL,
  });

  AuthUser copyWith({
    String? uid,
    String? email,
    String? name,
    String? photoURL,
  }) {
    return AuthUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'photoURL': photoURL,
    };
  }

  factory AuthUser.fromMap(Map<String, dynamic> map) {
    return AuthUser(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      photoURL: map['photoURL'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthUser.fromJson(String source) =>
      AuthUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthUser(uid: $uid, email: $email, name: $name, photoURL: $photoURL)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthUser &&
        other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ email.hashCode ^ name.hashCode ^ photoURL.hashCode;
  }

  bool get isEmpty => uid.isEmpty || name.isEmpty || email.isEmpty;
}
