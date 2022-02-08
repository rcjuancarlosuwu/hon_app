import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/features/onboarding/view/onboarding_authors/onboarding_authors.dart';
import 'package:hon_app/src/features/search/logic/providers.dart';

class AuthorSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 5) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              "El término de búsqueda debe ser más largo que 4 letras.",
            ),
          )
        ],
      );
    }

    return Consumer(builder: (_, ref, __) {
      final searchAuthors = ref.watch(searchAuthorsProvider(query));
      return searchAuthors.when(
        data: (authors) {
          return ListView.builder(
            itemCount: authors.length,
            itemBuilder: (_, i) {
              final author = authors[i];
              return ExpansionTile(
                leading: FittedBox(
                  child: AuthorImage(olid: author.olid),
                ),
                title: Text(author.name),
                subtitle: Text('Trabajos realizados ${author.worksCount}'),
                children: [
                  Text(author.birthDate ?? ''),
                  Text(author.deathDate ?? ''),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Trabajos: ${author.topSubjects?.join(', ')}'),
                  ),
                ],
              );
            },
          );
        },
        error: (_, __) => const Center(
          child: Text('Error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
