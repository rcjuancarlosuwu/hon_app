import 'package:hive/hive.dart';

import 'package:hon_app/src/core/constants/constants.dart';
import 'package:hon_app/src/core/services/local/refresh_token.dart';

abstract class ILocalDataSource {
  RefreshToken getRefreshToken();
  void saveRefreshToken(RefreshToken refreshToken);
  bool isOnboardingCompleted();
  void onboardingCompleted();
}

class LocalDataSource implements ILocalDataSource {
  LocalDataSource({required this.box});

  final Box box;

  @override
  RefreshToken getRefreshToken() {
    final refreshToken = box.get(refreshTokenKey, defaultValue: {});
    return RefreshToken.fromMap(Map<String, dynamic>.from(refreshToken));
  }

  @override
  void saveRefreshToken(RefreshToken refreshToken) {
    box.put(refreshTokenKey, refreshToken.toMap());
  }

  @override
  bool isOnboardingCompleted() {
    return box.get(onboardingKey, defaultValue: false);
  }

  @override
  void onboardingCompleted() {
    box.put(onboardingKey, true);
  }
}
