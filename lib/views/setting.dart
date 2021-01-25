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
                      builder: (context) =>
                          DetailView(title: "Penalty", detailIndex: 0)));
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
                          title: "Receiving Account", detailIndex: 1)));
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
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNoController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences prefs;
  String _title;
  int _detailIndex;
  int _penalty;
  String _receivedAccountNo;
  String _receivedBankName;
  final String conncectMessage = 'connect your Account';
  bool myAccountExist;
  bool prefsLoad;

  _DetailViewState(this._title, this._detailIndex);

  @override
  void initState() {
    prefsLoad = false;
    super.initState();
  }

  Future<bool> loadData() async {
    prefs = await SharedPreferences.getInstance();
    _penalty = (prefs.getInt('penalty') ?? 0);
    _receivedAccountNo = (prefs.getString('receivedAccountNo') ?? '00000000000000000');
    _receivedBankName = (prefs.getString('receivedBankName') ?? '은행명을 입력해주세요');

    if(_penalty != 0){
      _penaltyController.text = _penalty.toString();
    }
    if(_receivedAccountNo != '00000000000000000'){
      _accountNoController.text = _receivedAccountNo;
    }
    if(_receivedBankName != '은행명을 입력해주세요'){
      _bankNameController.text = _receivedBankName;
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
          if(_detailIndex == 0){
            if (_penaltyController.text.isEmpty) {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text("Enter price for your penalty.")));
            } else {
              setState(() {
                _penalty = int.parse(_penaltyController.text);
                print("penalty is changed: $_penalty");
              });
              prefs.setInt('penalty', _penalty);
              print((prefs.getInt('penalty') ?? 0));
              if(_penalty != 0){
                _penaltyController.text = _penalty.toString();
              }
            }
          }
          else if(_detailIndex == 1){
            // accountNo controller
            if (_accountNoController.text.isEmpty) {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text("Enter received Account numbers.")));
            } else {
              setState(() {
                _receivedAccountNo = _accountNoController.text;
                print("AccountNo is changed: $_receivedAccountNo");
              });
              prefs.setString('receivedAccountNo', _receivedAccountNo);
              print((prefs.getString('receivedAccountNo') ?? "no account number"));
              if(_receivedAccountNo != "no account number"){
                _accountNoController.text = _receivedAccountNo;
              }
            }
            // bankName controller
            if (_bankNameController.text.isEmpty) {
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text("Enter received bank name.")));
            } else {
              setState(() {
                _receivedBankName = _bankNameController.text;
                print("Bank Name is changed: $_receivedBankName");
              });
              prefs.setString('receivedBankName', _receivedBankName);
              print((prefs.getString('receivedBankName') ?? "은행명을 입력해주세요(한글)"));
              if(_receivedBankName != "은행명을 입력해주세요(한글)"){
                _bankNameController.text = _receivedBankName;
              }
            }
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
    TextStyle _textStyle = TextStyle(
        fontFamily: "AppleSDGothicNeo",
        fontWeight: FontWeight.w400,
        fontSize: 24,
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
              style: _textStyle.copyWith(fontSize: 18),
            ),
          ),
        ),
      ],
    );
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
                  decoration: InputDecoration.collapsed(
                      hintText: "00000",
                      hintStyle: _textStyle.copyWith(
                        color: Color.fromARGB(150, 35, 37, 43),
                      ),
                      border: InputBorder.none),
                ),
              ),
              Container(
                width: 23,
                alignment: Alignment.centerRight,
                child: Text(
                  "₩",
                  style: _textStyle,
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
        fontSize: 24,
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
            child: TextField(
              controller: _bankNameController,
              textAlign: TextAlign.right,
              style: _textStyle,
              decoration: InputDecoration.collapsed(
                hintText: '우리은행',
                hintStyle: _textStyle.copyWith(
                  color: Color.fromARGB(150, 35, 37, 43),
                ),
                  border: InputBorder.none
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: TextField(
              controller: _accountNoController,
              textAlign: TextAlign.right,
              style: _textStyle.copyWith(fontSize: 20),
              decoration: InputDecoration.collapsed(
                  hintText: '00000000000000000',
                  hintStyle: _textStyle.copyWith(
                    color: Color.fromARGB(150, 35, 37, 43), fontSize: 20
                  ),
                  border: InputBorder.none
              ),
            ),
          ),
        ),
      ],
    );
  }
}
