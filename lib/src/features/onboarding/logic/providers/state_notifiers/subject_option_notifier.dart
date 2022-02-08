import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/features/onboarding/logic/data/models/subject_option.dart';

class SubjectOptionsNotifier extends StateNotifier<List<SubjectOption>> {
  SubjectOptionsNotifier() : super(subjectsOptions);

  void select(String name) {
    state = [
      for (final subjectOption in state)
        if (subjectOption.name == name)
          subjectOption.copyWith(
            isSelected: !subjectOption.isSelected,
          )
        else
          subjectOption
    ];
  }
}
