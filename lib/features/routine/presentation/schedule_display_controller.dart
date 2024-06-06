import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:routine/features/routine/application/schedule_service.dart';
import 'package:routine/features/routine/domain/schedule.dart';

part 'schedule_display_controller.g.dart';

@riverpod
class ScheduleDisplayController extends _$ScheduleDisplayController {
  @override
  FutureOr<Schedule> build() {
    return ref.watch(scheduleServiceProvider).fetchSchedule();
  }
}
