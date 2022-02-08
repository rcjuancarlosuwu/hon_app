import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/core/widgets/buttons.dart';

import 'package:hon_app/src/features/onboarding/logic/data/models/subject_option.dart';
import 'package:hon_app/src/features/onboarding/logic/providers/providers.dart';
import 'package:hon_app/src/features/onboarding/view/onboarding_authors/onboarding_authors.dart';

class OnboardingSubjects extends StatelessWidget {
  const OnboardingSubjects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: const [
            Text(
              'Dejanos saber',
              style: TextStyle(fontSize: 30),
            ),
            Text(
              'lo qué te gusta',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            Text(
              'Elige tus temas favoritos para que podamos recomendarte los libros correctos para ti!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            OnboardingSubjectsOptions(),
            SizedBox(height: 25),
            OnboardingSubjectButton(),
          ],
        ),
      ),
    );
  }
}

class OnboardingSubjectButton extends ConsumerWidget {
  const OnboardingSubjectButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final visible = ref.watch(isSubjectOptionCompletedProvider);
    return Visibility(
      visible: visible,
      child: PrimaryButton(
        onPressed: () {
          ref.read(authorsOptionsProvider.notifier).getAuthorsOptions();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const OnboardingAuthors()),
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

class OnboardingSubjectsOptions extends ConsumerWidget {
  const OnboardingSubjectsOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsOptions = ref.watch(subjectsOptionsProvider);

    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 15,
      ),
      itemCount: subjectsOptions.length,
      itemBuilder: (_, i) => SubjectOptionCard(subjectsOptions[i]),
    );
  }
}

class SubjectOptionCard extends ConsumerWidget {
  const SubjectOptionCard(
    this.subjectOption, {
    Key? key,
  }) : super(key: key);

  final SubjectOption subjectOption;

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () =>
          ref.read(subjectsOptionsProvider.notifier).select(subjectOption.name),
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: subjectOption.isSelected
                ? Colors.blueAccent
                : Colors.grey.shade200,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              subjectOption.icon,
              style: const TextStyle(fontSize: 40),
            ),
            Text(
              subjectOption.displayName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
