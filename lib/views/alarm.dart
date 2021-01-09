import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

import '../models/alarm_model.dart';
import '../alarm_helper.dart';

class AlarmTab extends StatefulWidget {

  @override
  _AlarmTabState createState() => _AlarmTabState();
}

class _AlarmTabState extends State<AlarmTab> {
  DateTime _alarmTime;
  String _targetTime;
  bool _alarmOn;
  Alarm _alarm;
  bool doesExist;
  List<bool> isChecked =[
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  Future<DateTime> loadAlarm() async {
    print("load alarm");
    _alarm = await AlarmHelper().getAlarm(0);
    if(mounted){
      if (_alarm == Null) {
        setState(() {
          _alarmTime = DateTime.now();
          doesExist = false;
          _alarmOn = true;
        });
      } else {
        setState(() {
          _alarmTime = _alarm.alarmDateTime;
          doesExist = true;
          _alarmOn = _alarm.isPending == 1 ? true : false;
          isChecked[0] = _alarm.mon == 1? true: false;
          isChecked[1] = _alarm.tue == 1? true: false;
          isChecked[2] = _alarm.wed == 1? true: false;
          isChecked[3] = _alarm.thu == 1? true: false;
          isChecked[4] = _alarm.fri == 1? true: false;
          isChecked[5] = _alarm.sat == 1? true: false;
          isChecked[6] = _alarm.sun == 1? true: false;
        });
      }
    }

    print("finish alarm");

    return _alarmTime;
  }

  // ignore: non_constant_identifier_names
  @override
  Widget build(BuildContext context) {
    print("----------------alarm tab build");
    Size _size = MediaQuery
        .of(context)
        .size;
    double _width = _size.width;
    double _height = _size.height;

    TextStyle clockStyle = TextStyle(
      fontFamily: "AppleSDGothicNeo",
      fontWeight: FontWeight.w800,
      fontSize: 65,
      color: Color.fromARGB(255, 237, 234, 231),
    );

    return FutureBuilder(
      future: loadAlarm(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 35, 37, 43),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: _width * 0.9,
                    height: _height * 0.5,
                    child: Stack(alignment: Alignment.center, children: [
                      Wrap(
                        children: [
                          timePickerSpinner(),
                        ],
                      ),
                      Center(
                        child: Text(
                          ":",
                          style: clockStyle,
                        ),
                      ),
                      Positioned(
                        top: _height * 0.3 + 3,
                        child: Row(
                          children: [
                            Center(
                              child: Text("HOURS",
                                  style: clockStyle.copyWith(fontSize: 26)),
                            ),
                            Container(
                              width: _width * 0.1,
                            ),
                            Center(
                              child: Text("MINUTES",
                                  style: clockStyle.copyWith(fontSize: 25)),
                            )
                          ],
                        ),
                      )
                    ])),
                Container(
                  width: _width * 0.9,
                  height: _height * 0.07,
                  alignment: Alignment.topRight,
                  child: Switch(
                    onChanged: (bool value) async {
                      if(doesExist){
                        // updateAlarm
                        Alarm updateAlarm = Alarm(
                          id: 0,
                          alarmDateTime: _alarm.alarmDateTime,
                          isPending: value ? 1 : 0,
                          mon: isChecked[0] ? 1 : 0,
                          tue: isChecked[1] ? 1 : 0,
                          wed: isChecked[2] ? 1 : 0,
                          thu: isChecked[3] ? 1 : 0,
                          fri: isChecked[4] ? 1 : 0,
                          sat: isChecked[5] ? 1 : 0,
                          sun: isChecked[6] ? 1 : 0,
                        );
                        await AlarmHelper().updateAlarm(updateAlarm);
                      }else{
                        if(mounted){
                          setState(() {
                            doesExist = true;
                          });
                        }
                        // createAlarm
                        Alarm newAlarm = Alarm(
                          id: 0,
                          alarmDateTime: DateTime.now(),
                          isPending: value ? 1 : 0,
                          mon: isChecked[0] ? 1 : 0,
                          tue: isChecked[1] ? 1 : 0,
                          wed: isChecked[2] ? 1 : 0,
                          thu: isChecked[3] ? 1 : 0,
                          fri: isChecked[4] ? 1 : 0,
                          sat: isChecked[5] ? 1 : 0,
                          sun: isChecked[6] ? 1 : 0,
                        );
                        await AlarmHelper().createAlarm(newAlarm);
                      }
                    },
                    value: _alarmOn,
                    activeColor: Color.fromARGB(225, 17, 121, 34),
                    inactiveThumbColor: Color.fromARGB(205, 52, 46, 40),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: _width * 0.95,
                  height: _height * 0.1,
                  child: Row(
                    children: [
                      _day("M", 0),
                      _day("T", 1),
                      _day("W", 2),
                      _day("T", 3),
                      _day("F", 4),
                      _day("S", 5),
                      _day("S", 6),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
              child: CircularProgressIndicator()
          );
        }
      },
    );
  }

  Widget _day(String name, int day) {
    Color _checkedColor = Color.fromARGB(255, 237, 234, 231);
    TextStyle _textstyle = TextStyle(
        fontFamily: "AppleSDGothicNeo",
        fontWeight: FontWeight.w400,
        fontSize: 24,
        color: Color.fromARGB(255, 202, 194, 186));
    return Expanded(
      child: GestureDetector(
        onTap: () async {
          if(mounted){
            setState(() {
              print("ontap");
              if (isChecked[day]) {
                isChecked[day] = false;
              } else {
                isChecked[day] = true;
              }
            });
          }
          if(doesExist){
            // updateAlarm
            Alarm updateAlarm = Alarm(
              id: 0,
              alarmDateTime: _alarm.alarmDateTime,
              isPending: _alarm.isPending,
              mon: isChecked[0] ? 1 : 0,
              tue: isChecked[1] ? 1 : 0,
              wed: isChecked[2] ? 1 : 0,
              thu: isChecked[3] ? 1 : 0,
              fri: isChecked[4] ? 1 : 0,
              sat: isChecked[5] ? 1 : 0,
              sun: isChecked[6] ? 1 : 0,
            );
            await AlarmHelper().updateAlarm(updateAlarm);
          }else{
            if(mounted){
              setState(() {
                doesExist = true;
              });
            }
            // createAlarm
            Alarm newAlarm = Alarm(
              id: 0,
              alarmDateTime: DateTime.now(),
              isPending: 0,
              mon: isChecked[0] ? 1 : 0,
              tue: isChecked[1] ? 1 : 0,
              wed: isChecked[2] ? 1 : 0,
              thu: isChecked[3] ? 1 : 0,
              fri: isChecked[4] ? 1 : 0,
              sat: isChecked[5] ? 1 : 0,
              sun: isChecked[6] ? 1 : 0,
            );
            await AlarmHelper().createAlarm(newAlarm);
          }
        },
        child: isChecked[day]
            ? Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 156, 143, 128)),
          child: Text(
            name,
            style: _textstyle.copyWith(color: _checkedColor),
          ),
        )
            : Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 2.5, right: 2.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color.fromARGB(255, 156, 143, 128)),
            color: Color.fromARGB(255, 35, 37, 43),
          ),
          child: Text(
            name,
            style: _textstyle,
          ),
        ),
      ),
    );
  }

  Widget timePickerSpinner() {
    TextStyle highlightTextStyle = new TextStyle(
      fontFamily: "AppleSDGothicNeo",
      fontWeight: FontWeight.w800,
      fontSize: 78,
      color: Color.fromARGB(255, 250, 249, 248),
    );
    TextStyle normalTextStyle = new TextStyle(
      fontFamily: "AppleSDGothicNeo",
      fontWeight: FontWeight.w800,
      fontSize: 75,
      color: Color.fromARGB(255, 75, 79, 93),
    );

    Size _size = MediaQuery
        .of(context)
        .size;
    double _width = _size.width;
    double _height = _size.height;

    return new TimePickerSpinner(
      time: _alarmTime,
      normalTextStyle: normalTextStyle,
      highlightedTextStyle: highlightTextStyle,
      alignment: Alignment.center,
      itemHeight: _height * 0.15,
      itemWidth: _width * 0.3,
      isForce2Digits: true,
      onTimeChange: (time) async {
        if(mounted){
          setState(() {
            _alarmTime = time;
          });
        }
        if (doesExist) {
          // update alarm
          Alarm updateAlarm = Alarm(
            id: 0,
            alarmDateTime: time,
            isPending: _alarmOn ? 1 : 0,
            mon: isChecked[0] ? 1 : 0,
            tue: isChecked[1] ? 1 : 0,
            wed: isChecked[2] ? 1 : 0,
            thu: isChecked[3] ? 1 : 0,
            fri: isChecked[4] ? 1 : 0,
            sat: isChecked[5] ? 1 : 0,
            sun: isChecked[6] ? 1 : 0,
          );
          await AlarmHelper().updateAlarm(updateAlarm);
        } else {
          // create alarm
          Alarm newAlarm = Alarm(
            id: 0,
            alarmDateTime: time,
            isPending: _alarmOn ? 1 : 0,
            mon: isChecked[0] ? 1 : 0,
            tue: isChecked[1] ? 1 : 0,
            wed: isChecked[2] ? 1 : 0,
            thu: isChecked[3] ? 1 : 0,
            fri: isChecked[4] ? 1 : 0,
            sat: isChecked[5] ? 1 : 0,
            sun: isChecked[6] ? 1 : 0,
          );
          await AlarmHelper().createAlarm(newAlarm);
        }
        print("new Date Time: ${_alarmTime}");
      },
    );
  }
}