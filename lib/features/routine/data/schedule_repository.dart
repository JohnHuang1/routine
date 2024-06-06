import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine/features/routine/domain/schedule.dart';

abstract class ScheduleRepository {
  Future<Schedule> fetchSchedule();

  Stream<Schedule> watchSchedule();

  Future<void> setSchedule(Schedule schedule);
}

final scheduleRepositoryProvider =
    Provider<ScheduleRepository>(throw UnimplementedError());
