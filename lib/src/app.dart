import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hon_app/src/features/dashboard/view/dashboard_page.dart';
import 'package:hon_app/src/features/onboarding/logic/providers/providers.dart';
import 'package:hon_app/src/features/onboarding/view/onboarding_subjects/onboarding_subjects.dart';

import 'core/providers/providers.dart';
import 'core/constants/constants.dart';
import 'core/theme/theme.dart';
import 'features/authentication/view/auth_page.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authUserStreamProvider);
    final isOnboardingCompleted = ref.watch(isOnboardingCompletedProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      home: authUser.when(
        data: (user) {
          return user.isEmpty
              ? const AuthPage()
              : isOnboardingCompleted
                  ? const DashboardPage()
                  : const OnboardingSubjects();
        },
        error: (_, __) => const Center(child: Text('Error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      theme: honTheme,
    );
  }
}
