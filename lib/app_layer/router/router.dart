import 'package:assignment/app_layer/router/names.dart';
import 'package:assignment/presentation_payer/edit/edit.dart';
import 'package:assignment/presentation_payer/home/home.dart';
import 'package:flutter/material.dart';

class ASNavigator {
  static Map<String, WidgetBuilder> routes() {
    return {
      ASRoutesNames.home.path: (context) => const HomePage(),
      ASRoutesNames.edit.path: (context) => const EditPage(),
    };
  }
}
