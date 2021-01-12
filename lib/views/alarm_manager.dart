import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:alarm_with_bank_transfer/views/turn_off.dart';

Future<void> loadAlarmManager(DateTime alarmTime, alarmID) async {
  print("load alarm Manager");
  await AndroidAlarmManager.oneShotAt(alarmTime, alarmID, callBack);
}

Future<Widget> callBack() async {
  return TurnOff(targetTime: "10:13",);
}
