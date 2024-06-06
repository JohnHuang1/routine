import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine/features/routine/data/schedule_repository.dart';
import 'package:routine/features/routine/domain/schedule.dart';

import '../domain/routine.dart';

class ScheduleService {
  ScheduleService({
    required this.scheduleRepository,
  });

  final ScheduleRepository scheduleRepository;

  Future<Schedule> fetchSchedule() async {
    return scheduleRepository.fetchSchedule();
  }

  Future<void> setRoutine(Routine routine) async {
    final schedule = await scheduleRepository.fetchSchedule();
    final updated = schedule.setRoutine(routine);
    await scheduleRepository.setSchedule(updated);
  }
}

final scheduleServiceProvider = Provider<ScheduleService>((ref) {
  return ScheduleService(
      scheduleRepository: ref.watch(scheduleRepositoryProvider));
});
