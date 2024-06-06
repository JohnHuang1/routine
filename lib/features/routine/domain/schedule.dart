import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:routine/features/routine/domain/routine.dart';

part 'schedule.freezed.dart';

@freezed
class Schedule with _$Schedule {
  const factory Schedule({
    required List<RoutineID> routines,
  }) = _Schedule;
}

extension MutableSchedule on Schedule {
  Schedule setRoutine(Routine routine) {
    final copy = List<RoutineID>.from(routines);
    copy.add(routine.id);
    return copyWith(routines: copy);
  }
}