import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/features/dashboard/logic/data/models/liked_author.dart';
import 'package:hon_app/src/features/dashboard/logic/data/models/liked_work.dart';
import 'package:hon_app/src/features/dashboard/logic/providers/providers.dart';
import 'package:hon_app/src/features/onboarding/view/onboarding_authors/onboarding_authors.dart';
import 'package:hon_app/src/features/onboarding/view/onboarding_works/onboarding_works.dart';

import '../dashboard_page.dart';

class RecommendationSheet extends StatelessWidget {
  const RecommendationSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: .2,
      minChildSize: .2,
      maxChildSize: .4,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E2138),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -3),
                color: const Color(0xFF1E2138).withOpacity(.2),
                blurRadius: 2,
              )
            ],
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            controller: scrollController,
            child: Column(
              children: [
                const ScrollBar(color: Colors.white),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Recomendación',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Consumer(builder: (_, ref, __) {
                      return IconButton(
                        onPressed: () {
                          ref
                              .read(recommendationProvider.notifier)
                              .getRecommendation();
                        },
                        icon: const Icon(Icons.refresh, color: Colors.white),
                      );
                    })
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Consumer(builder: (_, ref, __) {
                    final recommendation = ref.watch(recommendationProvider);
                    return recommendation.when(
                      data: (data) {
                        if (data.type == 'works') {
                          final work = LikedWork.fromMap(data.recomendation);
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: WorkImage(id: work.cover.toString()),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: [
                                        Text(
                                          work.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          work.olid,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                work.description,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          );
                        } else {
                          final author = LikedAuthor.fromMap(
                            data.recomendation,
                          );
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: AuthorImage(olid: author.olid),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: [
                                        Text(
                                          author.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          author.birthDate ??
                                              author.deathDate ??
                                              '',
                                          style: const TextStyle(
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Text(author.bio ?? ''),
                              Text(author.wikipedia ?? ''),
                              Text(author.bookBrainz ?? ''),
                              Text(author.inventaire ?? '')
                            ],
                          );
                        }
                      },
                      error: (_, __) => const Center(
                        child: Text('Error'),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
