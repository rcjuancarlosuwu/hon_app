import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/core/providers/providers.dart';
import 'package:hon_app/src/core/widgets/buttons.dart';
import 'package:hon_app/src/features/dashboard/logic/providers/providers.dart';
import 'package:hon_app/src/features/dashboard/view/dashboard_page.dart';

import 'package:hon_app/src/features/onboarding/logic/data/models/work_option.dart';
import 'package:hon_app/src/features/onboarding/logic/providers/providers.dart';

class OnboardingWorks extends StatelessWidget {
  const OnboardingWorks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          kToolbarHeight,
          20,
          20,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: const [
              Text(
                'Solo un paso más',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                'Para terminar',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              Text(
                'Elige algunos trabajos en base a tus autores conocidos',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              OnboardingWorksOptions(),
            ],
          ),
        ),
      ),
      floatingActionButton: const OnboardingWorksButton(),
    );
  }
}

class OnboardingWorksButton extends ConsumerWidget {
  const OnboardingWorksButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final visible = ref.watch(isWorksOptionsCompletedProvider);
    return Visibility(
      visible: visible,
      child: PrimaryButton(
        onPressed: () {
          ref.read(worksOptionsProvider.notifier).saveLikedWorks();
          ref.read(localDataSourceProvider).onboardingCompleted();
          ref.read(likedAuthorsProvider.notifier).getAuthors();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const DashboardPage()),
          );
        },
        child: const Text(
          'Finalizar',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class OnboardingWorksOptions extends ConsumerWidget {
  const OnboardingWorksOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authorsOptions = ref.watch(worksOptionsProvider);

    return authorsOptions.when(
      data: (author) => GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
          childAspectRatio: 1 / 1.5,
        ),
        itemCount: author.length,
        itemBuilder: (_, i) => WorkOptionCard(author[i]),
      ),
      error: (_, __) => const Text('Error :('),
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 40),
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ),
      ),
    );
  }
}

class WorkOptionCard extends ConsumerWidget {
  const WorkOptionCard(
    this.workOption, {
    Key? key,
  }) : super(key: key);

  final WorkOption workOption;

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () =>
          ref.read(worksOptionsProvider.notifier).select(workOption.olid),
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: workOption.isSelected
                ? Colors.blueAccent
                : Colors.grey.shade200,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            WorkImage(id: workOption.cover.toString()),
            Text(
              workOption.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
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
