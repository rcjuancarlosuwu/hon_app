import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/features/search/logic/providers.dart';

class IsbnSearchDelegate extends SearchDelegate {
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
    if (query.length < 10) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              "El término de búsqueda debe tener 10 letras.",
            ),
          )
        ],
      );
    }

    return Consumer(builder: (_, ref, __) {
      final searchEdition = ref.watch(searchEditionProvider(query));
      return searchEdition.when(
        data: (edition) {
          return ListTile(
            leading: FittedBox(
              child: EditionImage(id: edition.olid),
            ),
            title: Text(edition.title),
            subtitle: Text('ISBN: ${edition.isbn10}'),
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

class EditionImage extends StatelessWidget {
  const EditionImage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://covers.openlibrary.org/b/olid/$id-M.jpg',
      imageBuilder: (context, imageProvider) {
        return Container(
          width: 60,
          height: 80,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/book.png')),
          ),
          foregroundDecoration: BoxDecoration(
            image: DecorationImage(image: imageProvider),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        );
      },
      placeholder: (_, __) => const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
      errorWidget: (_, __, ___) => const Icon(Icons.error),
    );
  }
}
