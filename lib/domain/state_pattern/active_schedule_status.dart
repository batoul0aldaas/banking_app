
import 'package:flutter/material.dart';
import '../entities/schedule_status.dart';

class ActiveScheduleStatus implements ScheduleStatus {
  @override
  String get key => 'active';

  @override
  String get label => 'ACTIVE';

  @override
  Color get color => Colors.green;

  @override
  String get actionLabel => 'Pause';

  @override
  bool get canToggle => true;
}
