import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/core/providers/providers.dart';
import 'package:hon_app/src/features/dashboard/logic/data/models/recommendation.dart';

class RecommendationNotifier extends StateNotifier<AsyncValue<Recommendation>> {
  RecommendationNotifier(this.ref) : super(const AsyncLoading());

  final Ref ref;

  getRecommendation() async {
    state = const AsyncLoading();
    try {
      final recommendation =
          await ref.read(remoteDataSourceProvider).getRecommendation();
      state = AsyncData(recommendation);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
