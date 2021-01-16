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
  int timeDifference;
  String _targetTime;
  Timer _timer;
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
    if(_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery
        .of(context)
        .size;
    double _width = _size.width;
    double _height = _size.height;

    _targetTime = DateFormat('HH:mm').format(widget.alarmTime);

    countDown();

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
                  if(_timer != null){
                    _timer.cancel();
                    _timer = null;
                  }
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

  void countDown(){
    DateTime now = DateTime.now();
    // get time difference in minutes
    timeDifference = widget.alarmTime.difference(now).inMinutes;

    if(timeDifference <0){
      if(_timer != null){
        _timer.cancel();
        _timer = null;
      }
      Navigator.pop(context);
    }

    // if difference is less than 2 minutes
    if(timeDifference <2 && timeDifference >= 0){
      // get time difference in seconds
      print("tick tok");
      timeDifference = widget.alarmTime.difference(now).inSeconds;
      if(timeDifference == 0){
        print("time set!");
        setState(() {
          restTime = 0;
        });
      }else{
        startProgressBar();
      }
    }else{
      print("countDown");
      if(timeDifference < 5){
        print("more than 1 minutes left($timeDifference)");
        _timer = Timer.periodic(Duration(minutes: 1), (timer) {
          print("finish");
          setState(() {
            timer.cancel();
            timer = null;
          });
        });
      }else if(timeDifference < 30){
        print("more than 5 minutes left($timeDifference)");
        _timer = Timer.periodic(Duration(minutes: 5), (timer) {
          print("finish");
          setState(() {
            timer.cancel();
            timer = null;
          });
        });
      }else if(timeDifference <120){
        print("more than 30 minutes left($timeDifference)");
        _timer = Timer.periodic(Duration(minutes: 30), (timer) {
          print("finish");
          setState(() {
            timer.cancel();
            timer = null;
          });
        });
      }else{
        print("more than 60 minutes left($timeDifference)");
        _timer = Timer.periodic(Duration(minutes: 60), (timer) {
          print("finish");
          setState(() {
            timer.cancel();
            timer = null;
          });
        });
      }
    }
  }

  void startProgressBar(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(!_progressStart){
          stride = 1/timeDifference;
          _progressStart = true;
        }
        restTime -= stride;
        timer.cancel();
        timer = null;
      });
    });
  }
}
