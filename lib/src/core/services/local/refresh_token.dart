import 'dart:convert';

class RefreshToken {
  final String? accessToken;
  final String? refreshToken;

  const RefreshToken({
    this.accessToken,
    this.refreshToken,
  });

  RefreshToken copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return RefreshToken(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory RefreshToken.fromMap(Map<String, dynamic> map) {
    return RefreshToken(
      accessToken: map['accessToken'],
      refreshToken: map['refreshToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RefreshToken.fromJson(String source) =>
      RefreshToken.fromMap(json.decode(source));

  @override
  String toString() =>
      'RefreshToken(accessToken: $accessToken, refreshToken: $refreshToken)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RefreshToken &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode;
}
