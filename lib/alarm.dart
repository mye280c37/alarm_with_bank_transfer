import 'package:flutter/material.dart';

List<bool> IsChecked = [true, false, false, false, false, false, false,];

class AlarmTab extends StatefulWidget {
  @override
  _AlarmTabState createState() => _AlarmTabState();
}

class _AlarmTabState extends State<AlarmTab> {
  bool alarm_on = true;
  // ignore: non_constant_identifier_names
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;

    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 35, 37, 43),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: _width*0.8,
            height: _height*0.5,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15,),
          Container(
            width: _width*0.9,
            height: _height*0.1,
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  if(alarm_on){
                    alarm_on = false;
                  }else{
                    alarm_on = true;
                  }
                });
              },
              child: alarm_on? Icon(
                Icons.alarm_on,
                color: Color.fromARGB(255, 237, 234, 231),
                size: _height*0.05,
              ): Icon(
                Icons.alarm_off,
                color: Color.fromARGB(200, 118, 113, 113),
                size: _height*0.05,
              ),
            ),
          ),
          SizedBox(height: 15,),
          Container(
            width: _width*0.95,
            height: _height*0.1,
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

  Widget _day(String name, int day){
    Color _checkedColor = Color.fromARGB(255, 237, 234, 231);
    TextStyle _textstyle = TextStyle(
        fontFamily: "AppleSDGothicNeo",
        fontWeight: FontWeight.w400,
        fontSize: 24,
        color: Color.fromARGB(255, 202, 194, 186)
    );
    return Expanded(
      child: GestureDetector(
        onTap: (){
          setState(() {
            print("ontap");
            if(IsChecked[day]){
              IsChecked[day] = false;
            }else{
              IsChecked[day] = true;
            }
          });
        },
        child: IsChecked[day]? Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 2.5, right: 2.5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 156, 143, 128)
          ),
          child: Text(
            name,
            style: _textstyle.copyWith(color: _checkedColor),
          ),
        ): Container(
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
}
