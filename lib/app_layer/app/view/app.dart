import 'package:assignment/app_layer/router/names.dart';
import 'package:assignment/app_layer/router/router.dart';
import 'package:assignment/l10n/l10n.dart';
import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final ASNavigator navigator;
  const App({
    super.key,
    required this.navigator,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: const ColorScheme.light(
          primary: ASColors.primary,
          secondary: ASColors.secondary,
        ),
      ),
      onGenerateRoute: navigator.generateRoute,
      navigatorKey: navigator.navigatorKey,
      initialRoute: ASRoutesNames.home.path,
    );
  }
}
