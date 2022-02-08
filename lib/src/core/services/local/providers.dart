import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'local_data_source.dart';

final localBoxProvider = Provider<Box>((_) => throw UnimplementedError());

final localDataSourceProvider = Provider<ILocalDataSource>((ref) {
  return LocalDataSource(box: ref.watch(localBoxProvider));
});
