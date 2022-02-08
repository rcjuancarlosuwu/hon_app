import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'src/app.dart';
import 'src/core/constants/constants.dart';
import 'src/core/providers/providers.dart';

Future<void> main() async {
  await Hive.initFlutter();
  final box = await Hive.openBox(localBoxName);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(
    ProviderScope(
      overrides: [
        localBoxProvider.overrideWithValue(box),
      ],
      child: const App(),
    ),
  );
}
