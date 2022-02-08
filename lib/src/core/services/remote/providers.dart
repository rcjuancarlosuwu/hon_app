import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hon_app/src/core/constants/constants.dart' show baseUrl;
import 'package:hon_app/src/core/services/local/providers.dart';
import 'interceptors/api_inteceptor.dart';
import 'remote_data_source.dart';

final appInterceptorProvider = Provider<ApiInterceptor>((ref) {
  return ApiInterceptor(localDataSource: ref.watch(localDataSourceProvider));
});

final clientProvider = Provider<Dio>((ref) {
  final interceptor = ref.watch(appInterceptorProvider);
  final options = BaseOptions(baseUrl: baseUrl);
  return Dio(options)..interceptors.add(interceptor);
});

final remoteDataSourceProvider = Provider<IRemoteDataSource>((ref) {
  return RemoteDataSource(client: ref.watch(clientProvider));
});
