import 'package:flutter/material.dart';

import 'history.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Alarm",),
              Tab(text: "Setting",),
              Tab(text: "History",),
            ],
          ),
        ),
        body: Center(
          child: Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 35, 37, 43),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 10,
                  child: _buttons(context),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            height: _height*0.08,
          ),
        ),
      ),
    );
  }

  Widget _buttons(BuildContext context){
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;
    return Container(
        width: _width,
        height: _height*0.08,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                child: _button("Alarm"),
              ),
            ),
              Container(
                width: 0.5,
                decoration: BoxDecoration(
                color: Color.fromARGB(255, 202, 194, 186)
                ),
              ),
            Expanded(
              child: GestureDetector(
                child: _button("Setting"),
              ),
            ),
            Container(
              width: 0.5,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 202, 194, 186)
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => History(),
                  ));
                  },
                child: _button("History"),
                ),
            ),
          ],
    )
    );
  }

  Widget _button(String title){
    return Container(
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "AppleSDGothicNeo",
            fontWeight: FontWeight.w400,
            fontSize: 24,
            color: Color.fromARGB(255, 202, 194, 186)
          ),
        ),
      ),
    );
  }
}
