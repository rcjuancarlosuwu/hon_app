import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/core/providers/providers.dart';

import 'package:hon_app/src/features/onboarding/logic/data/models/work_option.dart';
import 'package:hon_app/src/features/onboarding/logic/providers/providers.dart';

class WorkOptionsNotifier extends StateNotifier<AsyncValue<List<WorkOption>>> {
  WorkOptionsNotifier(this.ref) : super(const AsyncLoading());

  final Ref ref;

  Future<void> getWorksOptions() async {
    final authorsOptions = ref.read(selectedAuthorOptions);
    try {
      final worksOptions = await ref
          .read(remoteDataSourceProvider)
          .getWorksOptions(authorsOptions);
      state = AsyncData(worksOptions);
    } catch (e) {
      state = AsyncError(e);
    }
  }

  void select(String olid) {
    if (state is AsyncData && state.asData != null) {
      final worksOption = state.asData!.value;
      state = AsyncData([
        for (final option in worksOption)
          if (option.olid == olid)
            option.copyWith(
              isSelected: !option.isSelected,
            )
          else
            option
      ]);
    }
  }

  Future<void> saveLikedWorks() async {
    final works = state.asData?.value.map((e) => e.olid).toList() ?? [];
    state = const AsyncLoading();
    try {
      await ref.read(remoteDataSourceProvider).saveLikedWorks(works);
    } catch (e) {
      state = AsyncError(e);
    }
  }
}
