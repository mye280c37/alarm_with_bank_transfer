import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingTab extends StatefulWidget {
  @override
  _SettingTabState createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  SharedPreferences prefs;

  final TextStyle menuStyle = TextStyle(
      fontFamily: "AppleSDGothicNeo",
      fontWeight: FontWeight.w400,
      fontSize: 21,
      color: Color.fromARGB(255, 35, 37, 43),
      shadows: [
        Shadow(
          blurRadius: 5.0,
          color: Colors.black.withOpacity(.3),
          offset: Offset(1.0, 1.0),
        )
      ]);

  final BoxDecoration _menuDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [Colors.white, Color.fromARGB(255, 202, 194, 186)]),
      boxShadow: [
        BoxShadow(
          blurRadius: 6.0,
          color: Colors.black.withOpacity(.2),
          offset: Offset(5.0, 6.0),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;

    return Container(
      width: _width,
      height: _height,
      padding: EdgeInsets.only(
          top: _height * 0.1, left: _width * 0.05, right: _width * 0.05),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 35, 37, 43),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailView(
                            title: "My Account",
                            detailIndex: 0,
                          )));
            },
            child: Container(
              width: _width * 0.9,
              height: _height * 0.09,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              decoration: _menuDecoration,
              child: Text(
                "My Account",
                textAlign: TextAlign.right,
                style: menuStyle,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailView(title: "Penalty", detailIndex: 1)));
            },
            child: Container(
              width: _width * 0.9,
              height: _height * 0.09,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              decoration: _menuDecoration,
              child: Text(
                "Penalty",
                textAlign: TextAlign.right,
                style: menuStyle,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailView(
                          title: "Receiving Account", detailIndex: 2)));
            },
            child: Container(
              width: _width * 0.9,
              height: _height * 0.09,
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              decoration: _menuDecoration,
              child: Text(
                "Recieving Account",
                textAlign: TextAlign.right,
                style: menuStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailView extends StatefulWidget {
  final String title;
  final int detailIndex;

  DetailView({@required this.title, @required this.detailIndex});

  @override
  _DetailViewState createState() => _DetailViewState(title, detailIndex);
}

class _DetailViewState extends State<DetailView> {
  final TextEditingController _penaltyController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences prefs;
  String _title;
  int _detailIndex;
  String _penalty;
  String _myAccount;
  final String conncectMessage = 'connect your Account';
  bool myAccountExist;
  bool prefsLoad;

  _DetailViewState(this._title, this._detailIndex);

  @override
  void initState() {
    prefsLoad = false;
    _penalty = "00,000";
    _penaltyController.text = _penalty;
    super.initState();
  }

  Future<bool> loadData() async {
    prefs = await SharedPreferences.getInstance();
    _penalty = (prefs.getString('penalty') ?? '00,000');
    _penaltyController.text = _penalty;
    _myAccount = (prefs.getString('myAccount') ?? conncectMessage);
    if (_myAccount == conncectMessage) {
      myAccountExist = false;
    } else {
      myAccountExist = true;
    }

    return true;
  }

  final TextStyle _titleStyle = TextStyle(
      fontFamily: "AppleSDGothicNeo",
      fontWeight: FontWeight.w400,
      fontSize: 21,
      color: Color.fromARGB(255, 250, 249, 248),
      shadows: [
        Shadow(
          blurRadius: 5.0,
          color: Colors.black.withOpacity(.3),
          offset: Offset(1.0, 1.0),
        )
      ]);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;

    return GestureDetector(
        onTap: () async {
          FocusScope.of(context).unfocus();
          if (_penaltyController.text.isEmpty) {
            _scaffoldKey.currentState.showSnackBar(
                SnackBar(content: Text("Enter price for your penalty.")));
          } else {
            setState(() {
              _penalty = _penaltyController.text;
              print("penalty is changed: $_penalty");
            });
            prefs.setString('penalty', _penalty);
            print((prefs.getString('penalty') ?? "00,000"));
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 35, 37, 43),
            title: Text(
              _title,
              style: _titleStyle,
            ),
          ),
          body: FutureBuilder(
            future: loadData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    width: _width,
                    height: _height,
                    padding: EdgeInsets.only(
                        top: _height * 0.05,
                        left: _width * 0.05,
                        right: _width * 0.05),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 35, 37, 43),
                    ),
                    child: _detailView(_detailIndex));
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              }
            },
          ),
        ));
  }

  Widget _detailView(int detailIndex) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;

    final BoxDecoration _boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [Colors.white, Color.fromARGB(255, 202, 194, 186)]),
        boxShadow: [
          BoxShadow(
            blurRadius: 6.0,
            color: Colors.black.withOpacity(.2),
            offset: Offset(5.0, 6.0),
          ),
        ]);

    if (detailIndex == 0) {
      return Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: _width * 0.9,
            height: _height * 0.28,
            decoration: _boxDecoration,
            padding: EdgeInsets.all(15),
            child: myAccountView(),
          )
        ],
      );
    } else if (detailIndex == 1) {
      return Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: _width * 0.9,
            height: _height * 0.2,
            decoration: _boxDecoration,
            padding: EdgeInsets.all(15),
            child: penaltyView(),
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: _width * 0.9,
            height: _height * 0.24,
            decoration: _boxDecoration,
            padding: EdgeInsets.all(15),
            child: receivingAccountView(),
          ),
        ],
      );
    }
  }

  Widget myAccountView() {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;

    TextStyle _textStyle = TextStyle(
        fontFamily: "AppleSDGothicNeo",
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Color.fromARGB(255, 35, 37, 43),
        shadows: [
          Shadow(
            blurRadius: 5.0,
            color: Colors.black.withOpacity(.3),
            offset: Offset(1.0, 1.0),
          )
        ]);

    return myAccountExist
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "01234522312345667",
                    style: _textStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "우리은행",
                    style: _textStyle,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "000,000₩",
                    style: _textStyle.copyWith(fontSize: 30),
                  ),
                ),
              ),
            ],
          )
        : Container(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                conncectMessage,
                style: _textStyle.copyWith(fontSize: 20),
              )),
              SizedBox(
                height: _height * 0.02,
              ),
              Container(
                width: _width * 0.5,
                height: _height * 0.08,
                child: RaisedButton(
                  onPressed: () async {
                    String result = await getOAuth();
                    print("result: $result");
                  },
                  color: Color.fromARGB(155, 156, 143, 128),
                  child: Center(
                    child: Text("CONNECT",
                        style: _textStyle.copyWith(fontSize: 30)),
                  ),
                ),
              ),
            ],
          ));
  }

  Widget penaltyView() {
    TextStyle _textStyle = TextStyle(
        fontFamily: "AppleSDGothicNeo",
        fontWeight: FontWeight.w400,
        fontSize: 30,
        color: Color.fromARGB(255, 35, 37, 43),
        shadows: [
          Shadow(
            blurRadius: 5.0,
            color: Colors.black.withOpacity(.3),
            offset: Offset(1.0, 1.0),
          )
        ]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 3,
          child: Container(),
        ),
        Expanded(
          flex: 3,
          child: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: TextField(
                  textAlign: TextAlign.right,
                  controller: _penaltyController,
                  style: _textStyle,
                  decoration: InputDecoration(
                      hintText: "00,000",
                      hintStyle: _textStyle.copyWith(
                        color: Color.fromARGB(150, 35, 37, 43),
                      ),
                      border: InputBorder.none),
                ),
              ),
              Container(
                width: 30,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Center(
                    child: Text(
                      "₩",
                      style: _textStyle,
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              "Every 30 seconds",
              style: _textStyle.copyWith(
                fontSize: 12,
                color: Color.fromARGB(255, 118, 113, 113),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget receivingAccountView() {
    TextStyle _textStyle = TextStyle(
        fontFamily: "AppleSDGothicNeo",
        fontWeight: FontWeight.w400,
        fontSize: 22,
        color: Color.fromARGB(255, 35, 37, 43),
        shadows: [
          Shadow(
            blurRadius: 5.0,
            color: Colors.black.withOpacity(.3),
            offset: Offset(1.0, 1.0),
          )
        ]);

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              "우리은행",
              style: _textStyle,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              "01234522312345667",
              style: _textStyle.copyWith(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
