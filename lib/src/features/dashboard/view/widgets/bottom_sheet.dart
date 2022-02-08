import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hon_app/src/core/animations/animations.dart';
import 'package:hon_app/src/core/providers/providers.dart';
import 'package:hon_app/src/features/onboarding/logic/providers/providers.dart';

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: const [
        RotateAnimation(
          child: Icon(CupertinoIcons.chevron_compact_down, size: 30),
        ),
        Text(
          'Opciones',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Divider(),
        ResetOnboarding(),
        SignOutOption(),
        Divider(height: 20),
        Text(
          'MIT License. Hon App, 2022',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }
}

class SignOutOption extends ConsumerWidget {
  const SignOutOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pop();
        ref.read(fireAuthProvider).signOut();
      },
      leading: const Icon(Icons.logout, size: 20),
      title: const Text(
        'Salir',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ResetOnboarding extends ConsumerWidget {
  const ResetOnboarding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pop();
        ref
            .read(isOnboardingCompletedProvider.notifier)
            .update((state) => !state);
      },
      leading: const Icon(Icons.settings, size: 20),
      title: const Text(
        'Establecer preferencias nuevamente',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
