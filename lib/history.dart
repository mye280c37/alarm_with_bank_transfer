import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;
    return Scaffold(
      body:Container(
        width: _width*0.33,
        height: _height*0.5,
        decoration: BoxDecoration(
          color: Colors.white60,
        ),
      ),
    );
  }
}
