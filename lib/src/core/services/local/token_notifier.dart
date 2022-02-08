import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/core/services/local/local_data_source.dart';
import 'package:hon_app/src/core/services/local/refresh_token.dart';

class TokenNotifier extends StateNotifier<RefreshToken> {
  TokenNotifier(this.localDataSource)
      : super(localDataSource.getRefreshToken());

  final ILocalDataSource localDataSource;

  void updateToken(RefreshToken token) {
    localDataSource.saveRefreshToken(token);
    state = token;
  }
}
