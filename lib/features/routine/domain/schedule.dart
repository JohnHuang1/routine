import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:routine/constants/type_id.dart';
import 'package:routine/features/routine/domain/routine.dart';

part 'schedule.freezed.dart';
part 'schedule.g.dart';

@freezed
class Schedule extends HiveObject with _$Schedule {
  Schedule._();

  @HiveType(typeId: TypeId.schedule)
  factory Schedule({
    @HiveField(0) required List<RoutineID> routines,
  }) = _Schedule;
}

extension MutableSchedule on Schedule {
  Schedule addRoutine(RoutineID id) {
    final copy = List<RoutineID>.from(routines);
    copy.add(id);
    return copyWith(routines: copy);
  }

  Schedule deleteRoutine(RoutineID id) {
    final copy = List<RoutineID>.from(routines);
    copy.remove(id);
    return copyWith(routines: copy);
  }
}