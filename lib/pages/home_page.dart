import 'package:flutter/material.dart';
import 'package:widget_lifecycle/pages/example_page.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key ?key, required this.counter, required this.onPress})
      : super(key: key);

  int counter;
  final Function(int) onPress;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {




  @override
  void didChangeDependencies() {
    print('Widget Lifecycle: didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('Widget Lifecycle: didUpdateWidget');
    if (this.widget.counter != oldWidget.counter) {
        print('Count has changed');

    }
  }

  @override
  void deactivate() {
    print('Widget Lifecycle: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('Widget Lifecycle: dispose');
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      widget.counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("//counter${widget.counter}");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${widget.counter}',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
            SizedBox(height: 8.0,),
            ElevatedButton(
              onPressed: (){  widget.onPress(widget.counter);}
              ,
              child: Text('Reset count'),
            ),
            SizedBox(height: 8.0,),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
  initCounter(){
    widget.onPress(widget.counter);
  }
}
