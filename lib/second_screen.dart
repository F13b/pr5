import 'package:flutter/material.dart';
import 'package:pr5/main_screen.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({Key? key, required this.changeTheme}) : super(key: key);
  final void Function(ThemeMode) changeTheme;
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => widget.changeTheme(
              Theme.of(context).brightness == Brightness.light
                  ? ThemeMode.dark
                  : ThemeMode.light),
                  child: Icon(Icons.sunny)),
      body: Center(
          child: Text(
              (ModalRoute.of(context)?.settings.arguments as String?) ?? "")),
    );
  }
}