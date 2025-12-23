import 'package:flutter/material.dart';

abstract class ScheduleStatus {
  String get key;           // active / paused
  String get label;         // ACTIVE / PAUSED
  Color get color;
  String get actionLabel;   // Pause / Activate
  bool get canToggle;
}
