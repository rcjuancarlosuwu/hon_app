import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/core/providers/providers.dart';
import 'package:hon_app/src/features/onboarding/logic/data/models/author_option.dart';
import 'package:hon_app/src/features/onboarding/logic/providers/providers.dart';

class AuthorOptionsNotifier
    extends StateNotifier<AsyncValue<List<AuthorOption>>> {
  AuthorOptionsNotifier(this.ref) : super(const AsyncLoading());

  final Ref ref;

  getAuthorsOptions() async {
    final subjectOptions = ref.read(selectedSubjectsOptions);
    try {
      final authorOptions = await ref
          .read(remoteDataSourceProvider)
          .getAuthorOptions(subjectOptions);
      state = AsyncData(authorOptions);
    } catch (e) {
      state = AsyncError(e);
    }
  }

  void select(String name) {
    if (state is AsyncData && state.asData != null) {
      final authorsOption = state.asData!.value;
      state = AsyncData([
        for (final subjectOption in authorsOption)
          if (subjectOption.name == name)
            subjectOption.copyWith(
              isSelected: !subjectOption.isSelected,
            )
          else
            subjectOption
      ]);
    }
  }
}
