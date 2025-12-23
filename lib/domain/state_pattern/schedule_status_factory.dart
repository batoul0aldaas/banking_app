import 'package:banking_app/domain/state_pattern/paused_schedule_status.dart';

import '../entities/schedule_status.dart';
import 'active_schedule_status.dart';

class ScheduleStatusFactory {
  static ScheduleStatus fromString(String status) {
    switch (status) {
      case 'active':
        return ActiveScheduleStatus();
      case 'paused':
        return PausedScheduleStatus();
      default:
        return PausedScheduleStatus();
    }
  }
}
