import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/features/dashboard/logic/data/models/liked_author.dart';
import 'package:hon_app/src/features/dashboard/logic/data/models/liked_work.dart';
import 'package:hon_app/src/features/dashboard/logic/data/models/recommendation.dart';
import 'package:hon_app/src/features/dashboard/logic/providers/state_notifiers/liked_authors_notifier.dart';
import 'package:hon_app/src/features/dashboard/logic/providers/state_notifiers/liked_works_notifier.dart';
import 'package:hon_app/src/features/dashboard/logic/providers/state_notifiers/recommendation_notifier.dart';

final likedAuthorsProvider =
    StateNotifierProvider<LikedAuthorsNotifier, AsyncValue<List<LikedAuthor>>>(
        (ref) {
  return LikedAuthorsNotifier(ref)..getAuthors();
});

final likedWorksProvider =
    StateNotifierProvider<LikedWorksNotifier, AsyncValue<List<LikedWork>>>(
        (ref) {
  return LikedWorksNotifier(ref)..getWorks();
});

final recommendationProvider =
    StateNotifierProvider<RecommendationNotifier, AsyncValue<Recommendation>>(
        (ref) {
  return RecommendationNotifier(ref)..getRecommendation();
});

final searchOptionProvider = StateProvider<String>((ref) {
  return 'Autor';
});
