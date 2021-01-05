import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  final BoxDecoration _tableDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 0.0),
          colors: [
            Color.fromARGB(255, 202, 194, 186),
            Color.fromARGB(255, 237, 234, 231),
          ]),
      boxShadow: [
        BoxShadow(
          blurRadius: 6.0,
          color: Colors.black.withOpacity(.2),
          offset: Offset(5.0, 6.0),
        ),
      ]
  );

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;
    return Container(
      width: _width,
      height: _height,
      color: Color.fromARGB(255, 35, 37, 43),
      padding: EdgeInsets.all(20).copyWith(top: 35),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: _tableDecoration,
          )
        ],
      ),
    );
  }
}
