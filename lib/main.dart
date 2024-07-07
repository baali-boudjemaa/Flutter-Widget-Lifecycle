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

//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
class _MyAppState extends State<MyApp> {
  int counter = 0;
  late String b='';

  void resetCounter(int a) {
    setState(() {
      //counter = 0;
      print("$a" + "objectsss$counter");
      counter = a;
    });
  }

  void incrementCounter(int b) {
    setState(() {
      print("$b" + "objectsss$b");
      counter = b;
    });
  }

  @override
  initState() {
    print("initState Called");
  }

  @override
  Widget build(BuildContext context) {
    print("main$b");
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
                incr: incrementCounter,
                datacallback: (atring) {
                  setState(() {
                    b = atring; print("main$atring");
                  });
                },
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
