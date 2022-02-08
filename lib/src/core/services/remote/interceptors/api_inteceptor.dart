import 'package:dio/dio.dart';

import 'package:hon_app/src/core/services/local/local_data_source.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor({required this.localDataSource});

  final ILocalDataSource localDataSource;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = localDataSource.getRefreshToken();
    options.headers['Authorization'] = 'Bearer ${token.accessToken}';
    super.onRequest(options, handler);
  }
}
