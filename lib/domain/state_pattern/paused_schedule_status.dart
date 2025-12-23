import 'package:flutter/material.dart';

import '../entities/schedule_status.dart';

class PausedScheduleStatus implements ScheduleStatus {
  @override
  String get key => 'paused';

  @override
  String get label => 'PAUSED';

  @override
  Color get color => Colors.orange;

  @override
  String get actionLabel => 'Activate';

  @override
  bool get canToggle => true;
}
