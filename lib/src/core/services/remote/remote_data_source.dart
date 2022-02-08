import 'package:dio/dio.dart';
import 'package:hon_app/src/core/constants/constants.dart';
import 'package:hon_app/src/core/services/local/refresh_token.dart';
import 'package:hon_app/src/features/dashboard/logic/data/models/liked_author.dart';
import 'package:hon_app/src/features/dashboard/logic/data/models/liked_work.dart';
import 'package:hon_app/src/features/dashboard/logic/data/models/recommendation.dart';
import 'package:hon_app/src/features/onboarding/logic/data/models/author_option.dart';
import 'package:hon_app/src/features/onboarding/logic/data/models/work_option.dart';
import 'package:hon_app/src/features/search/logic/data/models/search_author.dart';
import 'package:hon_app/src/features/search/logic/data/models/search_edition.dart';
import 'package:hon_app/src/features/search/logic/data/models/search_work.dart';

abstract class IRemoteDataSource {
  Future<void> revokeToken(String refreshToken);
  Future<RefreshToken> signInGoogle(String token);
  Future<List<AuthorOption>> getAuthorOptions(List<String> subjects);
  Future<List<WorkOption>> getWorksOptions(List<String> authors);
  Future<void> saveLikedWorks(List<String> works);
  Future<List<LikedAuthor>> getLikedAuthors();
  Future<List<LikedWork>> getLikedWorks();
  Future<Recommendation> getRecommendation();
  Future<List<SearchAuthor>> searchAuthor(String q);
  Future<List<SearchWork>> searchWork(String q);
  Future<SearchEdition> searchEdition(String q);
}

class RemoteDataSource implements IRemoteDataSource {
  RemoteDataSource({required this.client});

  final Dio client;

  @override
  Future<void> revokeToken(String refreshToken) async {
    await client.delete(authSignOut, data: {'refreshToken': refreshToken});
  }

  @override
  Future<RefreshToken> signInGoogle(String token) async {
    final response = await client.post(authSignIn, data: {'token': token});
    if (response.statusCode == 201) return RefreshToken.fromMap(response.data);
    return const RefreshToken();
  }

  @override
  Future<List<AuthorOption>> getAuthorOptions(List<String> subjects) async {
    try {
      final response = await client.post(
        onboardingSubjects,
        data: {'subjects': subjects},
      );
      if (response.statusCode == 201) {
        final authorsOptions = response.data as List<dynamic>;
        return authorsOptions.map((e) => AuthorOption.fromMap(e)).toList();
      } else {
        throw Exception();
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<WorkOption>> getWorksOptions(List<String> authors) async {
    try {
      final response = await client.post(
        onboardingAuthors,
        data: {'authors': authors},
      );
      if (response.statusCode == 201) {
        final authorsOptions = response.data as List<dynamic>;
        return authorsOptions.map((e) => WorkOption.fromMap(e)).toList();
      } else {
        throw Exception();
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> saveLikedWorks(List<String> works) async {
    try {
      final response = await client.post(
        onboardingWorks,
        data: {'works': works},
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception();
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<LikedAuthor>> getLikedAuthors() async {
    try {
      final response = await client.get(likedAuthors);
      if (response.statusCode == 200) {
        final likedAuthors = response.data as List<dynamic>;
        return likedAuthors.map((e) => LikedAuthor.fromMap(e)).toList();
      } else {
        throw Exception();
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<LikedWork>> getLikedWorks() async {
    try {
      final response = await client.get(likedWorks);
      if (response.statusCode == 200) {
        final likedAuthors = response.data as List<dynamic>;
        return likedAuthors.map((e) => LikedWork.fromMap(e)).toList();
      } else {
        throw Exception();
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<Recommendation> getRecommendation() async {
    try {
      final response = await client.get(recommendation);
      if (response.statusCode == 200) {
        return Recommendation.fromMap(response.data);
      } else {
        throw Exception();
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<SearchAuthor>> searchAuthor(String q) async {
    try {
      final response = await client.get(searchAuthors, queryParameters: {
        'q': q,
      });
      if (response.statusCode == 200) {
        final searchAuthors = response.data as List<dynamic>;
        return searchAuthors.map((e) => SearchAuthor.fromMap(e)).toList();
      } else {
        throw Exception();
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<SearchWork>> searchWork(String q) async {
    try {
      final response = await client.get(searchWorks, queryParameters: {
        'q': q,
      });
      if (response.statusCode == 200) {
        final searchWorks = response.data as List<dynamic>;
        return searchWorks.map((e) => SearchWork.fromMap(e)).toList();
      } else {
        throw Exception();
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<SearchEdition> searchEdition(String q) async {
    try {
      final response = await client.get(searchByISBN, queryParameters: {
        'q': q,
      });
      if (response.statusCode == 200) {
        return SearchEdition.fromMap(response.data);
      } else {
        throw Exception();
      }
    } catch (_) {
      rethrow;
    }
  }
}
