import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

import 'package:alarm_with_bank_transfer/history_helper.dart';

import 'package:alarm_with_bank_transfer/views/alarm.dart';
import 'package:alarm_with_bank_transfer/views/setting.dart';
import 'package:alarm_with_bank_transfer/views/history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final TextStyle tabBarStyle = TextStyle(
      fontFamily: "AppleSDGothicNeo",
      fontWeight: FontWeight.w400,
      fontSize: 21,
      color: Color.fromARGB(255, 202, 194, 186));

  @override
  void initState() {
    HistoryHelper().database.then((value) {
      print("----------initialize history database");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;
    double _height = _size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Center(
          child: TabBarView(
            children: [
              AlarmTab(),
              SettingTab(),
              HistoryTab(),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 35, 37, 43),
          child: Container(
            height: _height * 0.08,
            child: TabBar(
              indicatorColor: Color.fromARGB(255, 156, 143, 128),
              tabs: [
                _tab("Alarm"),
                _tab("Setting"),
                _tab("History"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Tab _tab(String title) {
    return Tab(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: "AppleSDGothicNeo",
            fontWeight: FontWeight.w400,
            fontSize: 24,
            color: Color.fromARGB(255, 202, 194, 186)),
      ),
    );
  }
}
