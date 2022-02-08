import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hon_app/src/core/constants/constants.dart';
import 'package:hon_app/src/core/providers/providers.dart';
import 'package:hon_app/src/core/widgets/widgets.dart' show PrimaryButton;

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: PrimaryButton(
        onPressed: () => ref.read(fireAuthProvider).signIn(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(googleIcon, width: googleIconWith),
            const _GoogleSignInText(),
          ],
        ),
      ),
    );
  }
}

class _GoogleSignInText extends StatelessWidget {
  const _GoogleSignInText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        'Iniciar Sesión con Google',
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
