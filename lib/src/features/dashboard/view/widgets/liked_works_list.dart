import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/features/dashboard/logic/providers/providers.dart';

class LikedWorksList extends ConsumerWidget {
  const LikedWorksList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final likedWorks = ref.watch(likedWorksProvider);

    return SizedBox(
      height: 280,
      child: likedWorks.when(
        data: (works) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: works.length,
            itemBuilder: (context, index) {
              final work = works[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: SizedBox(
                  width: 170,
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: WorkImage(id: work.cover ?? ''),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                work.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                work.description,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
      ),
    );
  }
}

class WorkImage extends StatelessWidget {
  const WorkImage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://covers.openlibrary.org/b/id/$id-M.jpg',
      imageBuilder: (context, imageProvider) {
        return Container(
          width: 120,
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
