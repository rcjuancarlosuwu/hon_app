import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/core/providers/providers.dart';
import 'package:hon_app/src/features/search/logic/data/models/search_author.dart';
import 'package:hon_app/src/features/search/logic/data/models/search_work.dart';
import 'package:hon_app/src/features/search/logic/data/models/search_edition.dart';

final searchAuthorsProvider =
    FutureProvider.family<List<SearchAuthor>, String>((ref, q) async {
  return ref.watch(remoteDataSourceProvider).searchAuthor(q);
});

final searchWorksProvider =
    FutureProvider.family<List<SearchWork>, String>((ref, q) async {
  return ref.watch(remoteDataSourceProvider).searchWork(q);
});

final searchEditionProvider =
    FutureProvider.family<SearchEdition, String>((ref, q) async {
  return ref.watch(remoteDataSourceProvider).searchEdition(q);
});
