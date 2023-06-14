import 'package:assignment/app_layer/router/names.dart';
import 'package:assignment/app_layer/router/router.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: ASNavigator.routes(),
      initialRoute: ASRoutesNames.home.path,
    );
  }
}
