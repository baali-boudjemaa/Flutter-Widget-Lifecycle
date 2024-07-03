import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;

  void resetCounter(int a) {
    setState(() {
      //counter = 0;
      print("objectsss$counter");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("zzzzzzzzzzzzzzzzzzz");
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Widget Lifecycle'),
        ),
        body: Center(
            child: SizedBox(
          height: 500,
          child: Stack(
            children: [
              MyHomePage(
                counter: counter,
                onPress: resetCounter,
              ),
              Positioned(
                bottom: 100,
                left: 50,
                child: Center(
                    child: Text(
                  "$counter",
                  style: Theme.of(context).textTheme.headline4,
                )),
              )
            ],
          ),
        )));
  }
}
