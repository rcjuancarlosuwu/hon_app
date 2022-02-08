import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/core/widgets/buttons.dart';
import 'package:hon_app/src/features/onboarding/logic/data/models/author_option.dart';

import 'package:hon_app/src/features/onboarding/logic/providers/providers.dart';
import 'package:hon_app/src/features/onboarding/view/onboarding_works/onboarding_works.dart';

class OnboardingAuthors extends StatelessWidget {
  const OnboardingAuthors({Key? key}) : super(key: key);

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
                'Vamos bien',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                'queremos conocerte mejor',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              Text(
                'Elige tus autores conocidos en base a los temas que escogiste',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              OnboardingAuthorsOptions(),
            ],
          ),
        ),
      ),
      floatingActionButton: const OnboardingAuhtorButton(),
    );
  }
}

class OnboardingAuhtorButton extends ConsumerWidget {
  const OnboardingAuhtorButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final visible = ref.watch(isAuthorOptionsCompletedProvider);
    return Visibility(
      visible: visible,
      child: PrimaryButton(
        onPressed: () {
          ref.read(worksOptionsProvider.notifier).getWorksOptions();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const OnboardingWorks()),
          );
        },
        child: const Text(
          'Siguiente',
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

class OnboardingAuthorsOptions extends ConsumerWidget {
  const OnboardingAuthorsOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authorsOptions = ref.watch(authorsOptionsProvider);

    return authorsOptions.when(
      data: (author) => GridView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
        ),
        itemCount: author.length,
        itemBuilder: (_, i) => AuhtorOptionCard(author[i]),
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

class AuhtorOptionCard extends ConsumerWidget {
  const AuhtorOptionCard(
    this.authorOption, {
    Key? key,
  }) : super(key: key);

  final AuthorOption authorOption;

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () =>
          ref.read(authorsOptionsProvider.notifier).select(authorOption.name),
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: authorOption.isSelected
                ? Colors.blueAccent
                : Colors.grey.shade200,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AuthorImage(olid: authorOption.olid),
            Text(
              authorOption.name,
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

class AuthorImage extends StatelessWidget {
  const AuthorImage({
    Key? key,
    required this.olid,
  }) : super(key: key);

  final String olid;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://covers.openlibrary.org/a/olid/$olid-M.jpg',
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          radius: 35,
          foregroundImage: imageProvider,
          backgroundImage: const AssetImage('assets/images/anonymous.png'),
          backgroundColor: Colors.grey.shade200,
        );
      },
      placeholder: (_, __) => const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      errorWidget: (_, __, ___) => const Icon(Icons.error),
    );
  }
}
