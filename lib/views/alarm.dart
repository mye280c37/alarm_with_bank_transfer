import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';


List<bool> IsChecked = [true, false, false, false, false, false, false,];

class AlarmTab extends StatefulWidget {
  @override
  _AlarmTabState createState() => _AlarmTabState();
}

class _AlarmTabState extends State<AlarmTab> {
  bool alarm_on = true;
  DateTime _dateTime;

  // ignore: non_constant_identifier_names
  @override
  Widget build(BuildContext context) {
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

    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 35, 37, 43),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 15,),
          Container(
              width: _width * 0.9,
              height: _height * 0.5,
              child: Stack(
                  alignment: Alignment.center,
                  children: [
                    timePickerSpinner(),
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
                            width: _width * 0.13,
                          ),
                          Center(
                            child: Text("MINUTES",
                                style: clockStyle.copyWith(fontSize: 25)),
                          )
                        ],
                      ),
                    )
                  ]
              )
          ),
          Container(
            width: _width * 0.9,
            height: _height * 0.07,
            alignment: Alignment.topRight,
            child: Switch(
              onChanged: (bool value) {
                setState(() {
                  alarm_on = value;
                });
              },
              value: alarm_on,
              activeColor: Color.fromARGB(225, 17, 121, 34),
              inactiveThumbColor: Color.fromARGB(205, 52, 46, 40),
            ),
          ),
          SizedBox(height: 15,),
          Container(
            width: _width * 0.95,
            height: _height * 0.1,
            child: Row(
              children: [
                _day("S", 0),
                _day("M", 1),
                _day("T", 2),
                _day("W", 3),
                _day("T", 4),
                _day("F", 5),
                _day("S", 6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _day(String name, int day) {
    Color _checkedColor = Color.fromARGB(255, 237, 234, 231);
    TextStyle _textstyle = TextStyle(
        fontFamily: "AppleSDGothicNeo",
        fontWeight: FontWeight.w400,
        fontSize: 24,
        color: Color.fromARGB(255, 202, 194, 186)
    );
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            print("ontap");
            if (IsChecked[day]) {
              IsChecked[day] = false;
            } else {
              IsChecked[day] = true;
            }
          });
        },
        child: IsChecked[day] ? Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 156, 143, 128)
          ),
          child: Text(
            name,
            style: _textstyle.copyWith(color: _checkedColor),
          ),
        ) : Container(
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
      fontSize: 67,
      color: Color.fromARGB(255, 237, 234, 231),
    );
    TextStyle normalTextStyle = new TextStyle(
      fontFamily: "AppleSDGothicNeo",
      fontWeight: FontWeight.w800,
      fontSize: 62,
      color: Color.fromARGB(255, 75, 79, 93),
    );

    Size _size = MediaQuery
        .of(context)
        .size;
    double _width = _size.width;
    double _height = _size.height;

    return new TimePickerSpinner(
      normalTextStyle: normalTextStyle,
      highlightedTextStyle: highlightTextStyle,
      alignment: Alignment.center,
      itemHeight: _height * 0.15,
      itemWidth: _width*0.3,
      isForce2Digits: true,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
          print("new Date Time: ${_dateTime}");
        });
      },
    );
  }
}