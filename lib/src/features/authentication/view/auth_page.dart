import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hon_app/src/core/constants/constants.dart';
import 'widgets/widgets.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(appName, style: appNameStyle),
            const Spacer(),
            SvgPicture.asset(signInImage, width: authImageWith),
            const Spacer(),
            Text(
              '¡Una nueva forma de explorar libros!',
              style: appDescriptionStyle,
            ),
            const SizedBox(height: 20),
            const GoogleSignInButton(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
