import 'package:flutter/material.dart';
import 'package:pr5/second_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key, required this.changeTheme}) : super(key: key);
  final void Function(ThemeMode) changeTheme;
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    SharedPreferences.getInstance().then((value) {
      if (value.containsKey("data")) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => SecondScreen(
                    changeTheme: widget.changeTheme,
                  ),
              settings: RouteSettings(arguments: value.getString("data"))),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => widget.changeTheme(
              Theme.of(context).brightness == Brightness.light
                  ? ThemeMode.dark
                  : ThemeMode.light),
                  child: Icon(Icons.sunny),),
      body: Padding(padding: EdgeInsets.all(20.0), 
      child: Center(child: Column(
          children: [
            SizedBox(
              height: 20,
              child: TextField(
                controller: controller,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0),
            child: ElevatedButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    SharedPreferences.getInstance().then((value) {
                      value.setString("data", controller.text);
                    });
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => SecondScreen(
                              changeTheme: widget.changeTheme,
                            ),
                        settings: RouteSettings(arguments: controller.text)),
                  );
                },
                child: Text("Перейти на второй экран")),)
          ],
        ),),) 
    );
  }
}
