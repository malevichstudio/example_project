import 'package:assignment/presentation_payer/common/buttons/primaty_button.dart';
import 'package:assignment/presentation_payer/common/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ASColors.primary,
        title: Text("Employee List"),
      ),
      floatingActionButton: PrimaryButton(
        height: 50,
        width: 50,
        onPressed: () {},
        icon: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Placeholder(),
      ),
    );
  }
}
