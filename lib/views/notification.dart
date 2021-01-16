import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationTest{

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  void initState() {
    var androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosSetting = IOSInitializationSettings();
    var initializationSettings =
    InitializationSettings(android: androidSetting, iOS: iosSetting);

    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    print("onSelectNotification");
  }

//  Future _showNotificationAtTime() async {
//    DateTime dateTime = new DateTime.now().add(new Duration(seconds: 5));
//    final String timeZoneName = DateTime.now().timeZoneName;
//    final timeZone = TimeZone();
//    final location = await timeZone.getLocation(timeZoneName);
//    var scheduledDate = tz.TZDateTime.from(dateTime, location);
//
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//        'your channel id', 'your channel name', 'your channel description',
//        importance: Importance.max, priority: Priority.high);
//
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => TurnOff(targetTime: "10:23")));
//
//    var iosPlatformChannelSpecifics =
//    IOSNotificationDetails(sound: 'slow_spring.board.aiff');
//    var platformChannelSpecifics = NotificationDetails(
//        android: androidPlatformChannelSpecifics,
//        iOS: iosPlatformChannelSpecifics);
//
//    await _flutterLocalNotificationsPlugin.zonedSchedule(
//        1,
//        "Alarm",
//        "10:23",
//        scheduledDate,
//        platformChannelSpecifics,
//        uiLocalNotificationDateInterpretation: null,
//        androidAllowWhileIdle: null,
//        payload: 'Hello Flutter');
//  }

  Future showNotificationRepeat() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);

    var iosPlatformChannelSpecifics =
    IOSNotificationDetails(sound: 'slow_spring.board.aiff');
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      '반복 Notification',
      '반복 Notification 내용',
      RepeatInterval.everyMinute,
      platformChannelSpecifics,
      payload: 'Hello Flutter',
    );
  }

  Future showNotificationWithSound() async {
    print("start create notification");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high);

    var iosPlatformChannelSpecifics =
    IOSNotificationDetails(sound: 'slow_spring.board.aiff');
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      '심플 Notification',
      '이것은 Flutter 노티피케이션!',
      platformChannelSpecifics,
      payload: 'Hello Flutter',
    );
  }
}

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("notification"),
        ),
        body: Container(
          height: height * 0.16,
          width: width * 0.3,
          color: Colors.amber,
        ));
  }
}