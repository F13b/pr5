import 'package:flutter/material.dart';
import 'package:pr5/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode currentMode;
  @override
  void initState() {
    currentMode = ThemeMode.system;
    SharedPreferences.getInstance().then((value) {
      if (value.containsKey("currTheme")) {
        setState(() {
          currentMode =
              value.getBool("currTheme")! ? ThemeMode.light : ThemeMode.dark;
        });
      } else {
        value.setBool(
            "currTheme", Theme.of(context).brightness == Brightness.light);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pr5 app',
      themeMode: currentMode,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('pr5 app'),
        ),
        body: Center(
          child: FirstScreen(
            changeTheme: (themeMode) => setState(() {
              currentMode = themeMode;
              SharedPreferences.getInstance().then((value) {
                value.setBool("currTheme", currentMode == ThemeMode.light);
              });
            }),
          ),
        ),
      ),
    );
  }
}
