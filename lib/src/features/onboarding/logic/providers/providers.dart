import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/core/providers/providers.dart';

import 'package:hon_app/src/features/onboarding/logic/data/models/author_option.dart';
import 'package:hon_app/src/features/onboarding/logic/data/models/subject_option.dart';
import 'package:hon_app/src/features/onboarding/logic/data/models/work_option.dart';
import 'package:hon_app/src/features/onboarding/logic/providers/state_notifiers/author_option_notifier.dart';
import 'package:hon_app/src/features/onboarding/logic/providers/state_notifiers/subject_option_notifier.dart';
import 'package:hon_app/src/features/onboarding/logic/providers/state_notifiers/work_option_notifier.dart';

final subjectsOptionsProvider =
    StateNotifierProvider<SubjectOptionsNotifier, List<SubjectOption>>((ref) {
  return SubjectOptionsNotifier();
});

final selectedSubjectsOptions = Provider<List<String>>((ref) {
  final subjectOptions = ref
      .watch(subjectsOptionsProvider)
      .where((e) => e.isSelected)
      .map((e) => e.name)
      .toList();
  return subjectOptions;
});

final isSubjectOptionCompletedProvider = Provider<bool>((ref) {
  return ref.watch(selectedSubjectsOptions).length >= 4;
});

final authorsOptionsProvider = StateNotifierProvider<AuthorOptionsNotifier,
    AsyncValue<List<AuthorOption>>>((ref) {
  return AuthorOptionsNotifier(ref);
});

final selectedAuthorOptions = Provider<List<String>>((ref) {
  final subjectOptions = ref
      .watch(authorsOptionsProvider)
      .asData
      ?.value
      .where((e) => e.isSelected)
      .map((e) => e.olid)
      .toList();
  return subjectOptions ?? [];
});

final isAuthorOptionsCompletedProvider = Provider<bool>((ref) {
  return ref.watch(selectedAuthorOptions).length >= 4;
});

final worksOptionsProvider =
    StateNotifierProvider<WorkOptionsNotifier, AsyncValue<List<WorkOption>>>(
        (ref) {
  return WorkOptionsNotifier(ref);
});

final selectedWorksOptions = Provider<List<String>>((ref) {
  final workOptions = ref
      .watch(worksOptionsProvider)
      .asData
      ?.value
      .where((e) => e.isSelected)
      .map((e) => e.olid)
      .toList();
  return workOptions ?? [];
});

final isWorksOptionsCompletedProvider = Provider<bool>((ref) {
  return ref.watch(selectedWorksOptions).length >= 6;
});

final isOnboardingCompletedProvider = StateProvider<bool>((ref) {
  return ref.watch(localDataSourceProvider).isOnboardingCompleted();
});
