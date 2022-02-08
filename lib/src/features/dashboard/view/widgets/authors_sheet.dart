import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/features/dashboard/logic/providers/providers.dart';
import 'package:hon_app/src/features/dashboard/view/dashboard_page.dart';

import '../../../onboarding/view/onboarding_authors/onboarding_authors.dart';

class AuthorsSheet extends StatelessWidget {
  const AuthorsSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .45,
      minChildSize: .45,
      snap: true,
      builder: (_, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -2),
                color: Colors.grey.withOpacity(.1),
                blurRadius: 2,
              )
            ],
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                const ScrollBar(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Autores',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Consumer(builder: (_, ref, __) {
                      return PopupMenuButton(
                        offset: const Offset(0, 40),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        icon: const Icon(Icons.more_horiz),
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            height: 35,
                            child: const Text('Refrescar'),
                            onTap: () {
                              ref
                                  .read(likedAuthorsProvider.notifier)
                                  .getAuthors();
                            },
                          ),
                        ],
                      );
                    })
                  ],
                ),
                Consumer(builder: (_, ref, __) {
                  final likedAuthors = ref.watch(likedAuthorsProvider);

                  return likedAuthors.when(
                    data: (authors) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 2 / 3,
                        ),
                        itemCount: authors.length,
                        itemBuilder: (context, index) {
                          final author = authors[index];
                          return SizedBox(
                            child: Column(
                              children: [
                                AuthorImage(olid: author.olid),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    author.name,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
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
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
