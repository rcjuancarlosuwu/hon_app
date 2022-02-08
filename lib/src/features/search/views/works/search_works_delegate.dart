import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/features/onboarding/view/onboarding_works/onboarding_works.dart';
import 'package:hon_app/src/features/search/logic/providers.dart';

class WorksSearchDelegate extends SearchDelegate {
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
      final searchWorks = ref.watch(searchWorksProvider(query));
      return searchWorks.when(
        data: (works) {
          return ListView.builder(
            itemCount: works.length,
            itemBuilder: (_, i) {
              final work = works[i];
              return ExpansionTile(
                leading: FittedBox(child: WorkImage(id: work.cover.toString())),
                title: Text(work.title),
                subtitle: Text('Número de páginas: ${work.numOfPages}'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Primeras oraciones: ${work.firstSentences?.join(', ')}',
                    ),
                  ),
                  Text(work.author[0]),
                  Text(work.firstPublishYear.toString()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ediciones: ${work.editions.join(', ')}',
                    ),
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
