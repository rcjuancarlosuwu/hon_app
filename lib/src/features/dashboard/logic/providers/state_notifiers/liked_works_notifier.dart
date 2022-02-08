import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/core/providers/providers.dart';
import 'package:hon_app/src/features/dashboard/logic/data/models/liked_work.dart';

class LikedWorksNotifier extends StateNotifier<AsyncValue<List<LikedWork>>> {
  LikedWorksNotifier(this.ref) : super(const AsyncLoading());

  final Ref ref;

  getWorks() async {
    state = const AsyncLoading();
    try {
      final likedWorks =
          await ref.read(remoteDataSourceProvider).getLikedWorks();
      state = AsyncData(likedWorks);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
