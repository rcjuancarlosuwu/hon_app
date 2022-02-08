import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/core/providers/providers.dart';
import 'package:hon_app/src/features/dashboard/logic/data/models/liked_author.dart';

class LikedAuthorsNotifier
    extends StateNotifier<AsyncValue<List<LikedAuthor>>> {
  LikedAuthorsNotifier(this.ref) : super(const AsyncLoading());

  final Ref ref;

  getAuthors() async {
    state = const AsyncLoading();
    try {
      final likedAuthors =
          await ref.read(remoteDataSourceProvider).getLikedAuthors();
      state = AsyncData(likedAuthors);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
