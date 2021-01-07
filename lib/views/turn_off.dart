import 'package:flutter/material.dart';


class TurnOff extends StatefulWidget {
  String targetTime;

  TurnOff({@required this.targetTime});

  @override
  _TurnOffState createState() => _TurnOffState();
}

class _TurnOffState extends State<TurnOff> {
  TextStyle clockStyle = TextStyle(
    fontFamily: "AppleSDGothicNeo",
    fontWeight: FontWeight.w800,
    fontSize: 100,
    color: Color.fromARGB(255, 237, 234, 231),
  );

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery
        .of(context)
        .size;
    double _width = _size.width;
    double _height = _size.height;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children:[
          Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 35, 37, 43),
            ),
          ),
          Positioned(
            top: _height*0.33,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.targetTime,
                textAlign: TextAlign.center,
                style: clockStyle,
              ),
            ),
          ),
          Positioned(
            bottom: _height*0.2,
            child: GestureDetector(
              child: Container(
                width: _width*0.5,
                height: _height*0.1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.8, 0.0),
                        colors: [
                          Color.fromARGB(255, 202, 194, 186),
                          Color.fromARGB(255, 237, 234, 231),
                          Color.fromARGB(255, 202, 194, 186),
                        ]),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6.0,
                        color: Colors.black.withOpacity(.2),
                        offset: Offset(5.0, 6.0),
                      ),
                    ]
                ),
                child: Text(
                  "STOP",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "AppleSDGothicNeo",
                    fontSize: 50,
                    color: Color.fromARGB(255, 35, 37, 43),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}