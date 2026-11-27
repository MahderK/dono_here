import 'package:flutter/material.dart' as flutter;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'core/router/app_router.dart';

class DonoHereApp extends ConsumerWidget {
  const DonoHereApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Dono Here',
      routerConfig: router,
      // Most screens use material_ui; sign-in still uses Flutter widgets.
      localizationsDelegates: const [
        flutter.DefaultMaterialLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
    );
  }
}
