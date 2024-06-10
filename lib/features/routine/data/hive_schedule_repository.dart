import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:routine/features/routine/data/schedule_repository.dart';
import 'package:routine/features/routine/domain/schedule.dart';

const scheduleKey = 'user-schedule';
const scheduleRepositoryKey = 'schedule';

class HiveScheduleRepository implements ScheduleRepository {
  HiveScheduleRepository({required this.box});

  final Box<Schedule> box;

  @override
  Future<Schedule> fetchSchedule() async {
    final schedule = box.get(scheduleKey);
    return Future.value(schedule ?? Schedule(routines: []));
  }

  @override
  Future<void> setSchedule(Schedule schedule) async {
    await box.put(scheduleKey, schedule);
  }

  @override
  Stream<Schedule> watchSchedule() {
    // TODO: implement watchSchedule
    throw UnimplementedError('WatchSchedule');
  }
}

final hiveScheduleRepositoryProvider = Provider<ScheduleRepository>(
  (ref) => throw UnimplementedError(),
);
