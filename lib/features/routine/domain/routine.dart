import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:routine/constants/type_id.dart';
import 'action.dart';

part 'routine.freezed.dart';
part 'routine.g.dart';

typedef RoutineID = int;

@freezed
class Routine extends HiveObject with _$Routine {
  Routine._();

  @HiveType(typeId: TypeId.routine)
  factory Routine({
    @HiveField(0) required RoutineID id,
    @HiveField(1) required String name,
    @HiveField(2) required List<ActionID> actions,
  }) = _Routine;
}

extension MutableRoutine on Routine {
  Routine insertAction(ActionID id, int? pos) {
    final copy = List<ActionID>.from(actions);
    if(pos != null) {
      copy.insert(pos, id);
    } else {
      copy.add(id);
    }
    return copyWith(actions: copy);
  }

  Routine setId(RoutineID id) {
    return copyWith(id: id);
  }

  Routine setName(String name) {
    return copyWith(name: name);
  }
}