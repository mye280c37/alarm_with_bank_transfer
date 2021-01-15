import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'dart:async';

class AlarmManager extends StatefulWidget {
  DateTime alarmTime;

  AlarmManager({@required this.alarmTime});

  @override
  _AlarmManagerState createState() => _AlarmManagerState();
}

class _AlarmManagerState extends State<AlarmManager> {
  double restTime = 1.0;
  String _targetTime;
  Timer _timer;
  int minutes;
  int seconds;
  bool _progressStart = false;
  double stride;

  final BoxDecoration _boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [
            Colors.white,
            Color.fromARGB(255, 202, 194, 186)
          ]),
      boxShadow: [
        BoxShadow(
          blurRadius: 6.0,
          color: Colors.black.withOpacity(.2),
          offset: Offset(5.0, 6.0),
        ),
      ]
  );

  final TextStyle textStyle = TextStyle(
      fontFamily: "AppleSDGothicNeo",
      fontWeight: FontWeight.w400,
      fontSize: 35,
      color: Color.fromARGB(255, 35, 37, 43),
      shadows: [
        Shadow(
          blurRadius: 5.0,
          color: Colors.black.withOpacity(.3),
          offset: Offset(1.0, 1.0),
        )
      ]
  );

  final TextStyle clockStyle = TextStyle(
    fontFamily: "AppleSDGothicNeo",
    fontWeight: FontWeight.w800,
    fontSize: 100,
    color: Color.fromARGB(255, 237, 234, 231),
  );

  void dispose(){
    if(_timer != null) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery
        .of(context)
        .size;
    double _width = _size.width;
    double _height = _size.height;

    _targetTime = DateFormat('HH:mm').format(widget.alarmTime);

    timeCount();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Color.fromARGB(255, 35, 37, 43),
          ),
          Positioned(
            top: _height*0.22,
            child: Container(
              width: _width*0.9,
              height: _width*0.9,
              child: CircularProgressIndicator(
                backgroundColor: Color.fromARGB(255, 35, 37, 43),
                valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 250, 249, 248),),
                value: restTime,
              ),
            ),
          ),
          Positioned(
            top: _height*0.22,
            child: Container(
              width: _width*0.9,
              height: _width*0.9,
              child: Center(
                child: Text(
                  _targetTime,
                  style: clockStyle,
                ),
              ),
            ),
          ),
          Positioned(
              bottom: _height*0.1,
              child: GestureDetector(
                onTap: (){
                  _timer.cancel();
                  _timer = null;
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: _boxDecoration,
                  child: Text(
                    "Turn OFF",
                    style: textStyle,
                  ),
                )
              )
          ),
        ],
      ),
    );
  }

  void timeCount() {
    DateTime now = DateTime.now();
    minutes = widget.alarmTime.difference(now).inMinutes;
    print("minutes: $minutes");
    if(minutes > 60){
      print("more than 60 minutes left");
      _timer = Timer.periodic(Duration(hours: 1), (timer) {
        if(mounted){
          setState(() {
            timer.cancel();
            minutes = widget.alarmTime.difference(now).inMinutes;
            print("minutes: $minutes");
          });
        }
      });
    }else if(minutes > 30){
      print("more than 30 minutes left");
      _timer = Timer.periodic(Duration(minutes: 30), (timer) {
        if(mounted){
          setState(() {
            timer.cancel();
            minutes = widget.alarmTime.difference(now).inMinutes;
            print("minutes: $minutes");
          });
        }
      });
    }else if (minutes > 10){
      print("more than 10 minutes left");
      _timer = Timer.periodic(Duration(minutes: 5), (timer) {
        if(mounted){
          setState(() {
            _timer.cancel();
            minutes = widget.alarmTime.difference(now).inMinutes;
            print("minutes: $minutes");
          });
        }
      });
    }else{
      seconds = widget.alarmTime.difference(now).inSeconds;
      if(seconds < 0){
        _timer.cancel();
        _timer = null;
      }else{
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          print("seconds count down start");
          if(mounted){
            setState(() {
              seconds = widget.alarmTime.difference(now).inSeconds;
              print("seconds: $seconds");
              if(seconds < 0){
                print("no difference");
                _timer.cancel();
                _timer = null;
              }
              if(seconds < 120 && seconds >= 0){
                if(!_progressStart){
                  _progressStart = true;
                  stride = 1/seconds;
                }else{
                  restTime -= stride;
                }
              }
            });
          }
        });
      }

    }
    print("now: $now");
    print("alarmTime: ${widget.alarmTime}");
  }
}
