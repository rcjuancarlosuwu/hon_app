import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/features/dashboard/logic/providers/providers.dart';
import 'package:hon_app/src/features/search/views/authors/search_authors_delegate.dart';
import 'package:hon_app/src/features/search/views/isbn/search_isbn_delegate.dart';
import 'package:hon_app/src/features/search/views/works/search_works_delegate.dart';

class SeachBar extends ConsumerWidget {
  const SeachBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final searchOption = ref.watch(searchOptionProvider);
    return InkWell(
      onTap: () {
        switch (searchOption) {
          case 'Autor':
            showSearch(context: context, delegate: AuthorSearchDelegate());
            break;
          case 'Libro':
            showSearch(context: context, delegate: WorksSearchDelegate());
            break;
          default:
            showSearch(context: context, delegate: IsbnSearchDelegate());
            break;
        }
      },
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12.5,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(CupertinoIcons.search),
                const SizedBox(width: 10),
                Text(
                  'Buscar  $searchOption...',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            PopupMenuButton(
              offset: const Offset(0, 40),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              icon: const Icon(CupertinoIcons.slider_horizontal_3),
              itemBuilder: (_) => [
                PopupMenuItem(
                  height: 35,
                  child: const Text('Por ISBN'),
                  onTap: () {
                    ref.read(searchOptionProvider.notifier).state = 'ISBN';
                  },
                ),
                PopupMenuItem(
                  height: 35,
                  child: const Text('Por Autor'),
                  onTap: () {
                    ref.read(searchOptionProvider.notifier).state = 'Autor';
                  },
                ),
                PopupMenuItem(
                  height: 35,
                  child: const Text('Por libro'),
                  onTap: () {
                    ref.read(searchOptionProvider.notifier).state = 'Libro';
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
