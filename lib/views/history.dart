import 'package:flutter/material.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  final tableTitleStyle = TextStyle(
      fontFamily: "AppleSDGothicNeo",
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: 16,
      height: 1.8
  );

  final tableDetailStyle = TextStyle(
    fontFamily: "AppleSDGothicNeo",
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontSize: 14,
  );

  final BoxDecoration _tableDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 0.0),
          colors: [
            Color.fromARGB(255, 202, 194, 186),
            Colors.white,
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
              width: _width*0.9,
              height: _height*0.8,
              decoration: _tableDecoration,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: _height*0.01,
                  ),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: FractionColumnWidth(.27),
                      1: FractionColumnWidth(.39),
                      2: FractionColumnWidth(.34),
                    },
                    children: [
                      // title of each columns
                      TableRow(
                        // Title of each Column
                          decoration: BoxDecoration(
                            color: Color.fromARGB(0, 0, 0, 0),
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 35, 37, 43),
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 1.5),
                              child: Text("Date", style: tableTitleStyle, textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 1.5),
                              child: Text("TimeExceeded", style: tableTitleStyle, textAlign: TextAlign.center,),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 1.5),
                              child: Text("Penalty", style: tableTitleStyle, textAlign: TextAlign.center,),
                            ),
                          ]
                      ),
                    ],
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FractionColumnWidth(.27),
                          1: FractionColumnWidth(.39),
                          2: FractionColumnWidth(.34),
                        },
                        children: [
                          for(int i=0; i<20; i++)
                            dataRow(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height*0.01,
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }

  TableRow dataRow(){
    return TableRow(
        decoration: BoxDecoration(
            color: Color.fromARGB(0, 0, 0, 0),
        ),
        children: [
          Padding(
            padding: EdgeInsets.only(top:5, bottom: 5),
            child: Text("21-02-04", style: tableDetailStyle, textAlign: TextAlign.center,),
          ),
          Padding(
            padding: EdgeInsets.only(top:5, bottom: 5),
            child: Text("76 sec", style: tableDetailStyle, textAlign: TextAlign.center,),
          ),
          Padding(
            padding: EdgeInsets.only(top:5, bottom: 5),
            child: Text("00,000", style: tableDetailStyle, textAlign: TextAlign.center,),
          ),
        ]
    );
  }
}
